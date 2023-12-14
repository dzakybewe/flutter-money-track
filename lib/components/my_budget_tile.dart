import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyBudgetTile extends StatelessWidget {
  final String title;
  final String description;
  final String amount;
  final String startDate;
  final String endDate;
  final String amountUsed;
  final double progress;
  final VoidCallback onChanged;

  const MyBudgetTile({
    super.key,
    required this.title,
    required this.description,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.amountUsed,
    required this.progress,
    required this.onChanged
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: appPrimary,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ]
      ),
      child: Column(
        children: [
          // Title
          Stack(
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              Positioned.directional(
                textDirection: TextDirection.rtl,
                start: 10,
                top: 1,
                bottom: 1,
                child: IconButton(
                  onPressed: onChanged,
                  icon: const Icon(Icons.delete_forever),
                  iconSize: 24,
                  color: Colors.red,
                  alignment: AlignmentDirectional.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5,),
          Center(
            child: Text(
              '$startDate - $endDate',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amountUsed,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: LinearPercentIndicator(
              backgroundColor: Colors.white70,
              barRadius: const Radius.circular(15),
              animation: true,
              lineHeight: 20.0,
              animationDuration: 1500,
              percent: progress / 100,
              center: Text(
                "${progress.toString()}%",
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                ),
              ),
              progressColor: Colors.green,
            ),
          )
        ],
      ),
    );
  }
}
