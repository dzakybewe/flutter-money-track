import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/mini_header.dart';
import 'package:flutter_money_track/components/my_budget_tile.dart';
import 'package:flutter_money_track/pages/new_budget_page.dart';
import 'package:intl/intl.dart';

import '../auth/my_database.dart';
import '../components/colors.dart';
import '../supportwidgets/format_money.dart';


class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewBudgetPage()))
        },
        backgroundColor: appPrimary,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: MyDatabase().getBudgetsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('Loading'),
              );
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  const MiniHeader(title: 'Budgets'),
                  Center(
                      child: Text('Error: ${snapshot.error}')
                  ),
                ],
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Column(
                children: [
                  MiniHeader(title: 'Budgets'),
                  Center(
                    child: Text('No budgets available.'),
                  ),
                ],
              );
            }
            return Column(
              children: [
                const MiniHeader(title: 'Budgets'),
                /// Lanjutin kode dibawah sini biar ga numpuk
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NewBudgetPage()));
                    },
                    child: ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document){
                        double progress = 0.0;
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                        int amountUsedAsInt = data['amountUsed'];
                        double amountUsed = amountUsedAsInt.toDouble();
                        if (data['amountUsed'] == 0.0) {
                          progress = 0.0;
                        } else {
                          progress = (data['amountUsed'] / data['Amount']) * 100;
                        }

                        Timestamp p = data['startDate'] as Timestamp;
                        Timestamp q = data['endDate'] as Timestamp;
                        DateTime startDate = p.toDate();
                        DateTime endDate = q.toDate();

                        return MyBudgetTile(
                          title: data['Title'],
                          description: data['Description'],
                          amount: FormatMoney().getAmount(data['Amount']),
                          startDate: DateFormat('d MMM yyyy').format(startDate),
                          endDate: DateFormat('d MMM yyyy').format(endDate),
                          amountUsed: FormatMoney().getAmount(amountUsed),
                          progress: progress
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}

// Column(
//         children: [
//           const MiniHeader(title: 'Budget',),
//           /// Lanjutin Kode dibawah sini biar ga numpuk di header
//           Expanded(
//             child: ListView(
//               children: [
//                 MyBudgetTile()
//               ],
//             )
//           )
//         ],
//       ),