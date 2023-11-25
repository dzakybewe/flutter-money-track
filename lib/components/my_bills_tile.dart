import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/colors.dart';

class MyBillsTile extends StatelessWidget {
  final String title;
  final String description;
  final String amount;
  final String dueDate;
  final bool isFinished;
  Function(bool?)? onChanged;

  MyBillsTile({
    super.key,
    required this.title,
    required this.description,
    required this.amount,
    required this.dueDate,
    required this.isFinished,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      tileColor: Colors.white12,
      leading: Checkbox(
        value: isFinished,
        onChanged: onChanged,
        checkColor: appPrimary,
        activeColor: Colors.transparent,
        side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(width: 2.5, color: appPrimary, strokeAlign: 2),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        description.isNotEmpty ? description : 'No Description',
        style: const TextStyle(fontSize: 13, color: Colors.grey),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            amount, // Replace this with your amount variable
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isFinished?  appPrimary : Colors.red,
            ),
          ),
          const SizedBox(height: 3,),
          Text(
            dueDate,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
