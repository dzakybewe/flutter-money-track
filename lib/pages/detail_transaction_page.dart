import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/mini_header.dart';

class DetailTransactionPage extends StatelessWidget {
  final String type;
  final String category;
  final String date;
  final String time;
  final String description;
  final String amount;
  final String documentId;

  const DetailTransactionPage({
    super.key,
    required this.time,
    required this.description,
    required this.category,
    required this.date,
    required this.type,
    required this.amount,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MiniHeader(title: 'Transaction Details', backIcon: true, rightIcon: true,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 226, 226, 226),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.airline_stops_sharp,
                              size: 30.0, color: Colors.green),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: type == 'Expense' ? Colors.red : Colors.green,
                          background: Paint()
                            ..strokeWidth = 12.0
                            ..color = Colors.white
                            ..style = PaintingStyle.stroke
                            ..strokeJoin = StrokeJoin.round
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      amount,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25,),
                  const Text(
                    'Transaction Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  buildDetailRow('Type', type),
                  buildDetailRow('Category', category),
                  buildDetailRow('Date', date),
                  buildDetailRow('Time', time),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  buildDetailRow('Description', description),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: value == 'Expense' ? Colors.red : value == 'Income' ? Colors.green : Colors.black
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
