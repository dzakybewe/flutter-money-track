import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/pages/new_transaction_page.dart';
import 'package:flutter_money_track/supportwidgets/format_money.dart';
import 'package:intl/intl.dart';
import '../components/colors.dart';
import '../components/mini_header.dart';
import '../components/my_transaction_tile.dart';
import 'detail_transaction_page.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}
List<Transaction> allTransactions = [];
class _TransactionPageState extends State<TransactionPage> {

  List<Transaction> transactions = allTransactions;
  List<String> categories = ['Shopping', 'Groceries', 'Foods', 'Entertainment', 'Bills', 'Health', 'etc.'];
  List<String> selectedCategories = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NewTransactionPage()))
        },
        child: const Icon(Icons.add,),
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
              return Column(
                children: [
                  const MiniHeader(title: 'Transaction', backIcon: false, rightIcon: false,),
                  Center(
                      child: Text('Error: ${snapshot.error}')
                  ),
                ],
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Column(
                children: [
                  MiniHeader(title: 'Transaction', backIcon: false, rightIcon: false,),
                  Center(
                    child: Text('No transaction available.'),
                  ),
                ],
              );
            }

            transactions = snapshot.data!.docs.map((DocumentSnapshot document){
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              Timestamp q = data['Date'] as Timestamp;
              DateTime date = q.toDate();
              return Transaction(
                title: data['Title'],
                description: data['Description'],
                transactionCategory: data['transactionCategory'],
                amount: FormatMoney().getAmount(data['Amount'].toDouble()),
                type: data['transactionType'],
                date: date,
                documentId: document.id
              );
            }).toList();
            List<Transaction> filteredTransactions = transactions;
            filteredTransactions = transactions.where((transaction){
              return selectedCategories.isEmpty || selectedCategories.contains(transaction.transactionCategory);
            }).toList();

            return Column(
              children: [
                const MiniHeader(title: 'Transaction', backIcon: false, rightIcon: false,),
                /// Lanjutin kode dibawah sini biar ga numpuk
                const SizedBox(height: 20,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: categories
                          .map((category) => FilterChip(
                          label: Text(category),
                          labelStyle: TextStyle(
                            color: selectedCategories.contains(category) ? Colors.white : appPrimary
                          ),
                          selectedColor: appPrimary,
                          showCheckmark: false,
                          selected: selectedCategories.contains(category),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedCategories.add(category);
                              } else {
                                selectedCategories.remove(category);
                              }
                            });
                          }),
                      ).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailTransactionPage(
                                type: transaction.type,
                                description: transaction.description,
                                category: transaction.transactionCategory,
                                date: DateFormat('d MMM yyyy').format(transaction.date),
                                time: DateFormat.jm().format(transaction.date),
                                amount: transaction.amount,
                                documentId: transaction.documentId,
                              ),
                            ),
                          );
                        },
                        child: MyTransactionTile(
                          title: transaction.title,
                          description: transaction.description,
                          category: transaction.transactionCategory,
                          amount: transaction.amount,
                          type: transaction.type,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
        }
      ),
    );
  }
}
class Transaction{
  final String title;
  final String description;
  final String transactionCategory;
  final String amount;
  final String type;
  final DateTime date;
  final String documentId;

  Transaction({
    required this.title,
    required this.description,
    required this.transactionCategory,
    required this.amount,
    required this.type,
    required this.date,
    required this.documentId,
  });
}