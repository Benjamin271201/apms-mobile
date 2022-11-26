import 'package:apms_mobile/models/ticket_model.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TicketDetail extends StatefulWidget {
  final Ticket ticket;
  const TicketDetail({Key? key, required this.ticket}) : super(key: key);

  @override
  State<TicketDetail> createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  @override
  Widget build(BuildContext context) {
    var dateFormater = DateFormat("dd-MM-yyyy hh:mm:ss");
    final currencyFormatter = NumberFormat.currency(
      name: '₫',
      decimalDigits: 0,
      customPattern: '#,##0 \u00A4',
    );
    return Scaffold(
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 400,
              child: Stack(
                children: [
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.08,
                    top: MediaQuery.of(context).size.height * 0.1,
                    child: Container(
                      //width: MediaQuery.of(context).size.width*0.8,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      decoration: BoxDecoration(
                        color: const Color(0xffe3f2fd),
                        borderRadius: BorderRadius.circular(21),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            offset: Offset(2, 4),
                            blurRadius: 3.5,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0,
                                MediaQuery.of(context).size.width * 0.24, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Text(
                                    'Total fee:',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      color: const Color(0xff3192e1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  // quk (203:190)
                                  currencyFormatter
                                      .format(widget.ticket.totalFee),
                                  style: GoogleFonts.inter(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xff3192e1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // iconqrcodena6 (203:154)
                            padding: const EdgeInsets.only(right: 10),
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            width: 60,
                            height: 60,
                            child: const FittedBox(
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                color: Color(0xff3192e1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    // autogroupmd5cfdt (EzwVUdE3tWgudb7r5Vmd5c)
                    left: MediaQuery.of(context).size.width * 0.16,
                    top: MediaQuery.of(context).size.height * 0.3,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 25,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // nameBML (203:191)
                            margin: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width*0.32, 0),
                            child: Text(
                              'Name',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff828282),
                              ),
                            ),
                          ),
                          Text(
                            // platenumber6z6 (203:192)
                            'Plate Number',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff828282),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    // autogroupmd5cfdt (EzwVUdE3tWgudb7r5Vmd5c)
                    left: MediaQuery.of(context).size.width * 0.16,
                    top: MediaQuery.of(context).size.height * 0.34,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 25,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // nameBML (203:191)
                            margin: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width*0.164, 0),
                            child: Text(
                              widget.ticket.fullName,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            // platenumber6z6 (203:192)
                            widget.ticket.plateNumber,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        "${widget.ticket.carPark.name} - ${widget.ticket.carPark.addressNumber}, ${widget.ticket.carPark.street}, ${widget.ticket.carPark.ward}, ${widget.ticket.carPark.district}, ${widget.ticket.carPark.city}"),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Row(
                children: [
                  const Expanded(child: Text("Book time :")),
                  Expanded(
                    child: Text(widget.ticket.bookTime is DateTime
                        ? dateFormater.format(widget.ticket.bookTime!)
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
                    child: Text(widget.ticket.arriveTime is DateTime
                        ? dateFormater.format(widget.ticket.arriveTime!)
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
                    child: Text(widget.ticket.startTime is DateTime
                        ? dateFormater.format(widget.ticket.startTime!)
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
                    child: Text(widget.ticket.endTime is DateTime
                        ? dateFormater.format(widget.ticket.endTime!)
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
                                  .hasMatch(widget.ticket.picInUrl)
                              ? InkWell(
                                  child: Image.network(widget.ticket.picInUrl),
                                  onTap: () {
                                    showImageViewer(context,
                                        NetworkImage(widget.ticket.picInUrl));
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
                                  .hasMatch(widget.ticket.picOutUrl)
                              ? InkWell(
                                  child: Image.network(widget.ticket.picOutUrl),
                                  onTap: () {
                                    showImageViewer(context,
                                        NetworkImage(widget.ticket.picOutUrl));
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
                    child: Text(
                        currencyFormatter.format(widget.ticket.reservationFee)),
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
                    child:
                        Text(currencyFormatter.format(widget.ticket.totalFee)),
                  ),
                ],
              ),
            ),
            if (widget.ticket.status == 0)
              const ElevatedButton(
                onPressed: null,
                child: Text('Cancel'),
              )
          ],
        ),
      ),
    );
  }
}
