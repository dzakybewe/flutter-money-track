import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/components/colors.dart';

import '../auth/my_database.dart';
import '../supportwidgets/format_money.dart';

class MyBarGraph extends StatelessWidget {
  // final List weeklySummary;

  const MyBarGraph({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      color: Colors.transparent,
      child: StreamBuilder(
          stream: MyDatabase().db
              .collection("users")
              .doc(Authentication().currentUser!.email)
              .collection("user_transactions")
              .where('transactionType', isEqualTo: 'Expense')
              .orderBy("Date", descending: true,)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.black),),
              );
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No data available.', style: TextStyle(color: Colors.black),),
              );
            } else {
              List<TimeData> listChart = [];
              DateTime now = DateTime.now();
              DateTime startOfWeek = DateTime(now.year, now.month, now.day - 7);

              snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                Timestamp q = data['Date'] as Timestamp;
                DateTime date = q.toDate();

                // Check if the transaction date is within the current week
                if (date.isAfter(startOfWeek)) {
                  TimeData existingEntry = listChart.firstWhere(
                        (entry) => entry.domain.day == date.day && entry.domain.month == date.month,
                    orElse: () => TimeData(domain: date, measure: 0),
                  );

                  // Update the existing entry or add a new entry
                  if (listChart.contains(existingEntry)) {
                    listChart[listChart.indexOf(existingEntry)] =
                        TimeData(domain: date, measure: existingEntry.measure + data['Amount']);
                  } else {
                    listChart.add(TimeData(domain: date, measure: data['Amount']));
                  }
                }
              }).toList();

              final timeGroupList = [
                TimeGroup(
                  id: '1',
                  data: listChart,
                ),
              ];

              return AspectRatio(
                aspectRatio: 16/9,
                child: DChartBarT(
                  groupList: timeGroupList,
                  barLabelValue: (group, timeData, index) {
                    return FormatMoney().getAmount(timeData.measure.toDouble());
                  },
                  fillColor: (group, timeData, index) => appPrimary,
                ),
              );
            }
          }
      ),
    );
  }
}
