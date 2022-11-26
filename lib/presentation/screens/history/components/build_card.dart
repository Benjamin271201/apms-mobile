import 'dart:developer';

import 'package:apms_mobile/bloc/repositories/ticket_repo.dart';
import 'package:apms_mobile/bloc/ticket_bloc.dart';
import 'package:apms_mobile/models/ticket_model.dart';
import 'package:apms_mobile/presentation/screens/history/ticket_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

class BuildCard extends StatefulWidget {
  final String type;
  const BuildCard({Key? key, required this.type}) : super(key: key);

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  List items = [];
  int currentPage = 1;
  int maxPage = 1;
  ScrollController scrollController = ScrollController();
  bool loadMore = false;
  bool dateChanged = false;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );

  @override
  void initState() {
    start = dateRange.start;
    end = dateRange.end;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => TicketBloc(TicketRepo()),
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          scrollController.addListener(() {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              if (currentPage < maxPage) {
                setState(() {
                  if (mounted) {
                    currentPage++;
                    loadMore = true;
                  }
                });
                context.read<TicketBloc>().add(GetTicketList(
                    DateFormat('yyyy-MM-dd').format(start),
                    DateFormat('yyyy-MM-dd').format(end),
                    '',
                    widget.type,
                    currentPage,
                    loadMore));
                log(currentPage.toString());
              } else {
                log('No more page');
              }
            }
          });
          if (state is TicketInitial) {
            context.read<TicketBloc>().add(GetTicketList(
                DateFormat('yyyy-MM-dd').format(start),
                DateFormat('yyyy-MM-dd').format(end),
                '',
                widget.type,
                currentPage,
                loadMore));
            return _buildLoading();
          } else if (state is TicketLoading) {
            return _buildLoading();
          } else if (state is TicketLoaded) {
            maxPage = state.ticket.totalPage;
            if (items.isEmpty) {
              items = state.ticket.tickets;
            } else if(!listEquals(state.ticket.tickets, items)) {
              List newList = items + state.ticket.tickets;
              items = newList;
              loadMore = false;
            }

            return Builder(builder: (context) {
              return _buildCard(context, items, width);
            });
          }
          else {
            return Container();
          }
        },
      ),
    );
  }

  // Loading circle
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  // Build list
  Widget _buildCard(BuildContext context, List items, double width) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.4,
              child: const Text(
                'ALL',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: width * 0.6,
              child: TextButton(
                onPressed: () async {await pickDateRange(context);},
                child: Text(
                    "${DateFormat('dd/MM/yyyy').format(start)} - ${DateFormat('dd/MM/yyyy').format(end)}"),
              ),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              if (index == items.length) {
                return _buildLoading();
              }
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TicketDetail(ticket: items[index]),
                    ),
                  );
                },
                child: GFCard(
                  boxFit: BoxFit.cover,
                  title: GFListTile(
                    avatar: GFAvatar(
                        backgroundImage: loadImage(items[index].picInUrl)),
                    title: Text(
                      items[index].plateNumber,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    subTitle: Text(items[index].carPark.name),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _cardBody(items[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future pickDateRange(BuildContext context) async {
    TicketBloc bloc = context.read<TicketBloc>();
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      start = dateRange.start;
      end = dateRange.end;
      items = [];
      currentPage = 1;
      dateChanged = true;
    });
    bloc.add(ChangeTicketDate());
  }

  // Card Body
  List<Widget> _cardBody(Ticket ticket) {
    var dateFormater = DateFormat("dd-MM-yyyy HH:mm:ss");
    String checkinTime = ticket.startTime is DateTime
        ? dateFormater.format(ticket.startTime!)
        : "";
    final currencyFormatter = NumberFormat.currency(
      name: 'VND',
      decimalDigits: 0,
      customPattern: '#,##0 \u00A4',
    );
    if (ticket.status == 0 || ticket.status == -1) {
      String bookTime = ticket.bookTime is DateTime
          ? dateFormater.format(ticket.bookTime!)
          : "";
      String arriveTime = ticket.arriveTime is DateTime
          ? dateFormater.format(ticket.arriveTime!)
          : "";
      return [
        Row(
          children: [
            Flexible(
              child: Text("Book time: $bookTime"),
            ),
            Flexible(
              child: Text("Arrive time: $arriveTime"),
            ),
          ],
        ),
        const Divider(
          color: Colors.blue,
          //height: 25,
          thickness: 2,
        ),
        SizedBox(
          child: Text(
              "Reservation fee: ${currencyFormatter.format(ticket.reservationFee)}"),
        ),
      ];
    } else if (ticket.status == 1) {
      return [
        Row(
          children: [
            Flexible(
              child: Text("Check-in Time: $checkinTime"),
            ),
          ],
        ),
        const Divider(
          color: Colors.blue,
          //height: 25,
          thickness: 2,
        ),
        const SizedBox(
          child: Text("Duration: 0s"),
        ),
      ];
    } else {
      String checkoutTime = ticket.endTime is DateTime
          ? dateFormater.format(ticket.endTime!)
          : "";

      return [
        Row(
          children: [
            Flexible(
              child: Text("Check-in Time: $checkinTime"),
            ),
            Flexible(
              child: Text("Check-out Time: $checkoutTime"),
            ),
          ],
        ),
        const Divider(
          color: Colors.blue,
          //height: 25,
          thickness: 2,
        ),
        SizedBox(
          child:
              Text("Total fee: ${currencyFormatter.format(ticket.totalFee)}"),
        ),
      ];
    }
  }

  // Get images from firebase
  ImageProvider loadImage(String url) {
    var check = RegExp(r'^(https:\/\/firebasestorage\.googleapis\.com\/v0)')
        .hasMatch(url);

    Image img = (url.isEmpty || !check)
        ? Image.asset("assets/images/default.jpg")
        : Image.network(
            url,
            loadingBuilder: (context, child, loadingProgress) =>
                (loadingProgress == null)
                    ? child
                    : const CircularProgressIndicator(),
            errorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/images/default.jpg");
            },
          );
    return img.image;
  }
}
