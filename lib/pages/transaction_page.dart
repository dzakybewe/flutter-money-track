import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/pages/new_transaction_page.dart';
import 'package:flutter_money_track/supportwidgets/format_money.dart';
import '../components/colors.dart';
import '../components/mini_header.dart';
import '../components/my_transaction_tile.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewTransactionPage()))
        },
        backgroundColor: appPrimary,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: MyDatabase().getTransactionStream(),
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
                child: Text('No transaction available.'),
              );
            }
            return Column(
              children: [
                const MiniHeader(title: 'Transaction'),
                /// Lanjutin kode dibawah sini biar ga numpuk
                Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document){
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return MyTransactionTile(
                        title: data['Title'],
                        description: data['Description'],
                        category: data['transactionCategory'],
                        amount: FormatMoney().getAmount(data['Amount']),
                        type: data['transactionType'],
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