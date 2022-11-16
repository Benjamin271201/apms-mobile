import 'package:apms_mobile/models/ticket_model.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketDetail extends StatelessWidget {
  final Ticket ticket;
  const TicketDetail({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateFormater = DateFormat("dd-MM-yyyy hh:mm:ss");
    final currencyFormatter = NumberFormat.currency(
      name: 'VND',
      decimalDigits: 0,
      customPattern: '#,##0 \u00A4',
    );
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          height: MediaQuery.of(context).size.width * 0.2,
          width: MediaQuery.of(context).size.width * 0.2,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(style: BorderStyle.none)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Plate Number :")),
                Expanded(child: Text(ticket.plateNumber)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Car park address :")),
                Expanded(
                    child: Text(
                        "${ticket.carPark.name} - ${ticket.carPark.addressNumber}, ${ticket.carPark.street}, ${ticket.carPark.ward}, ${ticket.carPark.district}, ${ticket.carPark.city}")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Name :")),
                Expanded(child: Text(ticket.fullName)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Book time :")),
                Expanded(
                  child: Text(ticket.bookTime is DateTime
                      ? dateFormater.format(ticket.bookTime!)
                      : ""),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Arrive time :")),
                Expanded(
                  child: Text(ticket.arriveTime is DateTime
                      ? dateFormater.format(ticket.arriveTime!)
                      : ""),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Check-in time :")),
                Expanded(
                  child: Text(ticket.startTime is DateTime
                      ? dateFormater.format(ticket.startTime!)
                      : ""),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Check-out time :")),
                Expanded(
                  child: Text(ticket.endTime is DateTime
                      ? dateFormater.format(ticket.endTime!)
                      : ""),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                children: [
                  const Expanded(child: Text("Check-in picture :")),
                  Expanded(
                    child:
                        RegExp(r'^(https:\/\/firebasestorage\.googleapis\.com\/v0)')
                                .hasMatch(ticket.picInUrl)
                            ? InkWell(
                                child: Image.network(ticket.picInUrl),
                                onTap: () {
                                  showImageViewer(
                                      context, NetworkImage(ticket.picInUrl));
                                })
                            : const Text("No data"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                children: [
                  const Expanded(child: Text("Check-out picture :")),
                  Expanded(
                    child:
                        RegExp(r'^(https:\/\/firebasestorage\.googleapis\.com\/v0)')
                                .hasMatch(ticket.picOutUrl)
                            ? InkWell(
                                child: Image.network(ticket.picOutUrl),
                                onTap: () {
                                  showImageViewer(
                                      context, NetworkImage(ticket.picOutUrl));
                                })
                            : const Text("No data"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(child: Text("Reservation fee :")),
                Expanded(
                  child: Text(currencyFormatter.format(ticket.reservationFee)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              children: [
                const Expanded(
                    child:
                        Text("Total ( included booking and reservation ) :")),
                Expanded(
                  child: Text(currencyFormatter.format(ticket.totalFee)),
                ),
              ],
            ),
          ),
          if (ticket.status == 0)
            const ElevatedButton(
              onPressed: null,
              child: Text('Cancel'),
            )
        ],
      ),
    );
  }
}
