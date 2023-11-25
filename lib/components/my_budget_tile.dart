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

  const MyBudgetTile({
    super.key,
    required this.title,
    required this.description,
    required this.amount,
    required this.startDate,
    required this.endDate,
    required this.amountUsed,
    required this.progress
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: appPrimary,
      ),
      child: Column(
        children: [
          // Title
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
            ),
          ),
          Center(
            child: Text(
              '$startDate - $endDate',
              style: TextStyle(
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
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
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
