import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/supportwidgets/format_money.dart';

import 'colors.dart';

class MyWalletInfo extends StatefulWidget {
  const MyWalletInfo({super.key});

  @override
  State<MyWalletInfo> createState() => _MyWalletInfoState();
}

class _MyWalletInfoState extends State<MyWalletInfo> {
  double walletBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MyDatabase().getSumAmount(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          for (var doc in snapshot.data!.docs) {
            if (doc['transactionType'] == 'Income') {
              totalIncome += doc['Amount'];
              walletBalance += doc['Amount'];
            } else if (doc['transactionType'] == 'Expense') {
              totalExpense += doc['Amount'];
              walletBalance -= doc['Amount'];
            }
          }
          return Container(
            padding: const EdgeInsets.all(15),
            height: 175,
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
                        const Text('Total Balance', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                        const SizedBox(height: 5,),
                        Text(FormatMoney().getAmount(walletBalance), style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Income
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Income', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5,),
                          Text(FormatMoney().getAmount(totalIncome), style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),

                    // Expense
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Expenses', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5),
                          Text(FormatMoney().getAmount(totalExpense), style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                        ],
                      ),
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
          return const Text('Loading');
        }
      },
    );
  }
}
