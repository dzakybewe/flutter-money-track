import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/supportwidgets/format_money.dart';

import 'colors.dart';

class MyWalletInfo extends StatelessWidget {
  MyWalletInfo({super.key});

  double walletBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MyDatabase().getSumAmount(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          snapshot.data!.docs.forEach((doc) {
            if (doc['transactionType'] == 'Income') {
              totalIncome += doc['Amount'];
              walletBalance += doc['Amount'];
            } else if (doc['transactionType'] == 'Expense') {
              totalExpense += doc['Amount'];
              walletBalance -= doc['Amount'];
            }
          });
          return Container(
            padding: const EdgeInsets.all(15),
            height: 150,
            width: 320,
            decoration: BoxDecoration(
              color: appSecondary,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Balance', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                        SizedBox(height: 5,),
                        Text(FormatMoney().getAmount(walletBalance), style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),

                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Income
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Income', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5,),
                        Text(FormatMoney().getAmount(totalIncome), style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),

                    // Expense
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Expenses', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5),
                        Text(FormatMoney().getAmount(totalExpense), style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(15),
            height: 150,
            width: 320,
            decoration: BoxDecoration(
              color: appSecondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text('Something went wrong'),
            ),
          );
        } else {
          return Text('Loading');
        }

      },
    );
  }
}
