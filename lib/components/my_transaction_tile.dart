import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/colors.dart';

class MyTransactionTile extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String amount;
  final String type;


  const MyTransactionTile({super.key, required this.title, required this.description, required this.category, required this.amount, required this.type});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      tileColor: Colors.white12,
      title: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 5),
          Text(
            description.isNotEmpty ? description : 'No Description',
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
      subtitle: Text(
        category,
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
      trailing: Text(
        type == 'Expense' ? '- $amount' : '+ $amount', // Replace this with your amount variable
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: type == 'Expense' ? Colors.red : appPrimary,
        ),
      ),
    );
  }
}
