import 'dart:developer';

import 'package:apms_mobile/bloc/repositories/ticket_repo.dart';
import 'package:apms_mobile/bloc/ticket_bloc.dart';
import 'package:apms_mobile/models/ticket_model.dart';
import 'package:apms_mobile/presentation/screens/history/ticket_detail.dart';
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
  @override
  void initState() {
    super.initState();
    print('---First----');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => TicketBloc(TicketRepo()))],
      child: BlocBuilder<TicketBloc, TicketState>(
        builder: (context, state) {
          if (state is TicketInitial) {
            context
                .read<TicketBloc>()
                .add(GetTicketList('', '', '', widget.type, 1));
            return _buildLoading();
          } else if (state is TicketLoading) {
            return _buildLoading();
          } else if (state is TicketLoaded) {
            log(state.ticket.tickets.length.toString());
            return _buildCard(context, state.ticket, width);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  // Loading circle
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  // Build list
  Widget _buildCard(BuildContext context, TicketModel model, double width) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: width * 0.5,
              height: 20,
              child: const Text('From : 2022-01-01'),
            ),
            SizedBox(
                width: width * 0.5,
                height: 20,
                child: const Text(
                  "To: 2022-11-12",
                  textAlign: TextAlign.end,
                )),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: model.tickets.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TicketDetail(ticket: model.tickets[index]),
                    ),
                  );
                },
                child: GFCard(
                  boxFit: BoxFit.cover,
                  title: GFListTile(
                    avatar: GFAvatar(
                        backgroundImage:
                            loadImage(model.tickets[index].picInUrl)),
                    title: Text(
                      model.tickets[index].plateNumber,
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    subTitle: Text(model.tickets[index].carPark.name),
                  ),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _cardBody(model.tickets[index]),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Card Body
  List<Widget> _cardBody(Ticket ticket) {
    var dateFormater = DateFormat("dd-MM-yyyy hh:mm:ss");
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
