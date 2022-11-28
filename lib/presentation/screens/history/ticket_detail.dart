import 'dart:async';
import 'dart:developer';

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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    int duration = DateTime.now().difference(widget.ticket.startTime).inHours;


    log(DateTime.now().difference(widget.ticket.startTime).inDays.toString());
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
            // Fee header
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: FittedBox(
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xff3192e1),
                        )),
                  ),
                ),
                FittedBox(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.1,
                        screenHeigth * 0.1, screenWidth * 0.1, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: screenHeigth * 0.16,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 0, 20),
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
                            padding: const EdgeInsets.only(right: 10),
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                ),
              ],
            ),
            _buildBody(context, screenWidth,duration),
          ],
        ),
      ),
    );
  }

  // Return the suffix of ordinal number (st, nd ,th)
  String ordinal(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }

    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  SingleChildScrollView _buildBody(BuildContext context, double screenWidth, int duration) {
    var dateFormater = DateFormat("MMM yyyy");
    var timeFormater = DateFormat("HH:mm:ss");
    final currencyFormatter = NumberFormat.currency(
      name: '₫',
      decimalDigits: 0,
      customPattern: '#,##0 \u00A4',
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _halfLeft(screenWidth, dateFormater, timeFormater),
              _halfRight(
                  screenWidth, timeFormater, dateFormater, currencyFormatter),
            ],
          ),
          Divider(
            thickness: 2,
            indent: screenWidth * 0.12,
            endIndent: screenWidth * 0.12,
            height: 20,
            color: Colors.blue,
          ),
          _bodyTotal(screenWidth, currencyFormatter, duration)
        ],
      ),
    );
  }

  Row _bodyTotal(
    double screenWidth,
    NumberFormat currencyFormatter,
    int duration
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(children: [
          FittedBox(
            child: Container(
              width: screenWidth * 0.4,
              margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 20, 0, 0),
              child: SizedBox(
                height: 25,
                child: Text(
                  'Duration',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff828282),
                  ),
                ),
              ),
            ),
          ),
          FittedBox(
            child: Container(
              width: screenWidth * 0.4,
              margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 20, 0, 0),
              child: SizedBox(
                height: 25,
                child: Text(
                  'Total Fee',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff828282),
                  ),
                ),
              ),
            ),
          ),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FittedBox(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                height: 25,
                child: Text(
                  "$duration Hours",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          FittedBox(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: SizedBox(
                height: 25,
                child: Text(
                  currencyFormatter.format(widget.ticket.totalFee),
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Column _halfRight(double screenWidth, DateFormat timeFormater,
      DateFormat dateFormater, NumberFormat currencyFormatter) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Container(
            margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 40, 0, 0),
            child: SizedBox(
              height: 25,
              child: Text(
                'Plate Number',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff828282),
                ),
              ),
            ),
          ),
        ),
        FittedBox(
          child: Container(
            margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 6, 0, 0),
            child: SizedBox(
              height: 25,
              child: Text(
                widget.ticket.plateNumber,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        widget.ticket.arriveTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 26, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      'Arrive Time',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff828282),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Arrive Time
        widget.ticket.arriveTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 6, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      timeFormater.format(widget.ticket.arriveTime),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Arrive Date
        widget.ticket.arriveTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      "${widget.ticket.arriveTime.day}${ordinal(widget.ticket.arriveTime.day).toString()} ${dateFormater.format(widget.ticket.arriveTime!)}",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        widget.ticket.endTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 26, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      'Check-out Time',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff828282),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Arrive Time
        widget.ticket.endTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 6, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      timeFormater.format(widget.ticket.endTime),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Arrive Date
        widget.ticket.endTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 0, 0, 20),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      "${widget.ticket.endTime.day}${ordinal(widget.ticket.endTime.day).toString()} ${dateFormater.format(widget.ticket.endTime!)}",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        widget.ticket.reservationFee > 0
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.08, 26, 0, 20),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      currencyFormatter.format(widget.ticket.reservationFee),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Column _halfLeft(
      double screenWidth, DateFormat dateFormater, DateFormat timeFormater) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Container(
            margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 40, 0, 0),
            child: SizedBox(
              height: 25,
              child: Text(
                'Name',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff828282),
                ),
              ),
            ),
          ),
        ),
        // Name
        FittedBox(
          child: Container(
            margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 6, 0, 0),
            child: SizedBox(
              height: 25,
              child: Text(
                widget.ticket.fullName,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        widget.ticket.reservationFee > 0
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 26, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      'Reservation fee',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff828282),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        widget.ticket.bookTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 26, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      'Book Time',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff828282),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Book Time
        widget.ticket.bookTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 6, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      timeFormater.format(widget.ticket.bookTime!),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        widget.ticket.bookTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 0, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      "${widget.ticket.bookTime.day}${ordinal(widget.ticket.bookTime.day).toString()} ${dateFormater.format(widget.ticket.bookTime!)}",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        widget.ticket.startTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 26, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      'Check-in Time',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff828282),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Check-in Time
        widget.ticket.startTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 6, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      timeFormater.format(widget.ticket.startTime),
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        // Check-in Date
        widget.ticket.startTime is DateTime
            ? FittedBox(
                child: Container(
                  margin: EdgeInsets.fromLTRB(screenWidth * 0.14, 0, 0, 0),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      widget.ticket.startTime is DateTime
                          ? "${widget.ticket.startTime.day}${ordinal(widget.ticket.startTime.day).toString()} ${dateFormater.format(widget.ticket.startTime!)}"
                          : "No data",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}


// address format : "${widget.ticket.carPark.name} - ${widget.ticket.carPark.addressNumber}, ${widget.ticket.carPark.street}, ${widget.ticket.carPark.ward}, ${widget.ticket.carPark.district}, ${widget.ticket.carPark.city}"