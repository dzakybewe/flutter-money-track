import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/components/colors.dart';
import 'package:flutter_money_track/components/mini_header.dart';
import 'package:flutter_money_track/components/my_bills_tile.dart';
import 'package:flutter_money_track/pages/new_bills_page.dart';
import 'package:intl/intl.dart';

import '../auth/my_database.dart';
import '../supportwidgets/format_money.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({super.key});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewBillsPage()))
        },
        backgroundColor: appPrimary,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: MyDatabase().getBillsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('Loading'),
              );
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error: ${snapshot.error}')
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No bills available.'),
              );
            }
            return Column(
              children: [
                const MiniHeader(title: 'Bills'),
                /// Lanjutin kode dibawah sini biar ga numpuk
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document){
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      Timestamp t = data['dueDate'] as Timestamp;
                      DateTime dueDate = t.toDate();
                      return MyBillsTile(
                        title: data['Title'],
                        description: data['Description'],
                        amount: FormatMoney().getAmount(data['Amount']),
                        dueDate: DateFormat('d MMM yyyy').format(dueDate),
                        onChanged: (value) => {
                          MyDatabase().db
                              .collection('users')
                              .doc(Authentication().currentUser!.email)
                              .collection('user_bills')
                              .doc(document.id)
                              .update(
                              {'isFinished': !data['isFinished']}
                          )
                        },
                        isFinished: data['isFinished'],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
        }
      ),
    );
  }
}
