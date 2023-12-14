import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/components/mini_header.dart';
import 'package:flutter_money_track/components/my_budget_tile.dart';
import 'package:flutter_money_track/components/my_detail_budget_tile.dart';
import 'package:intl/intl.dart';

import '../supportwidgets/format_money.dart';

class BudgetDetailPage extends StatefulWidget {
  final String documentId;
  const BudgetDetailPage({super.key, required this.documentId});

  @override
  State<BudgetDetailPage> createState() => _BudgetDetailPageState();
}

class _BudgetDetailPageState extends State<BudgetDetailPage> {
  List<BudgetTransaction> budgetTransactions = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: MyDatabase().getBudgetDetail(widget.documentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            Map<String, dynamic>? budget = snapshot.data!.data() as Map<String, dynamic>;

            double progress = 0.0;
            // int amountUsedAsInt = data['amountUsed'];
            double amountUsed = budget['amountUsed'];
            if (budget['amountUsed'] == 0.0) {
              progress = 0.0;
            } else {
              progress = (budget['amountUsed'] / budget['Amount']) * 100;
            }

            Timestamp p = budget['startDate'] as Timestamp;
            Timestamp q = budget['endDate'] as Timestamp;
            DateTime startDate = p.toDate();
            DateTime endDate = q.toDate();

            return Column(
              children: [
                const MiniHeader(title: 'Detail', backIcon: true, rightIcon: true,),
                MyBudgetTile(
                  title: budget['Title'],
                  description: budget['Description'],
                  amount: FormatMoney().getAmount(budget['Amount']),
                  startDate: DateFormat('d MMM yyyy').format(startDate),
                  endDate: DateFormat('d MMM yyyy').format(endDate),
                  amountUsed: FormatMoney().getAmount(amountUsed),
                  progress: progress,
                  onChanged: () {

                  },
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: MyDatabase().getTransactionStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text('Loading'),
                      );
                    }
                    if (snapshot.hasError) {
                      return Column(
                        children: [
                          const MiniHeader(title: 'Budget Detail', backIcon: true, rightIcon: true,),
                          Center(
                              child: Text('Error: ${snapshot.error}')
                          ),
                        ],
                      );
                    }
                    if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                      return const Column(
                        children: [
                          MiniHeader(title: 'Budgets', backIcon: true, rightIcon: true,),
                          Center(
                            child: Text('No budgets available.'),
                          ),
                        ],
                      );
                    }
                    budgetTransactions = snapshot.data!.docs.map((DocumentSnapshot document){
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      Timestamp t = data['Date'] as Timestamp;
                      DateTime date = t.toDate();
                      return BudgetTransaction(
                        title: data['Title'],
                        amount: FormatMoney().getAmount(data['Amount'].toDouble()),
                        date: DateFormat('d MMM yyyy').format(date),
                        budgetName: data['budgetName']
                      );
                    }).toList();

                    List<BudgetTransaction> filteredBudgetTransaction = budgetTransactions.where((transaction){
                      return transaction.budgetName.contains(budget['Title']);
                    }).toList();

                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredBudgetTransaction.length,
                        itemBuilder: (context, index) {
                          final i = filteredBudgetTransaction[index];
                          return MyDetailBudgetTile(
                            title: i.title,
                            amount: i.amount,
                            date: i.date,
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            );
          } else {
            return const Text('No data');
          }
        },
      ),
    );
  }
}

class BudgetTransaction{
  final String title;
  final String amount;
  final String date;
  final String budgetName;

  BudgetTransaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.budgetName
  });
}
