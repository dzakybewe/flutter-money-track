import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/components/big_header.dart';
import 'package:flutter_money_track/components/my_button.dart';
import 'package:flutter_money_track/components/my_text_field.dart';
import 'package:flutter_money_track/supportwidgets/support_widgets_functions.dart';

class NewTransactionPage extends StatefulWidget {
  const NewTransactionPage({super.key});

  @override
  State<NewTransactionPage> createState() => _NewTransactionPageState();
}

var transactionType = ['Expense', 'Income'];
var transactionCategory = ['Shopping', 'Groceries', 'Foods', 'Entertainment', 'Bills', 'Health', 'etc.'];

class _NewTransactionPageState extends State<NewTransactionPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final transactionTypeController = TextEditingController();
  final transactionCategoryController = TextEditingController();
  final budgetController = TextEditingController();

  String? transactionTypeValue;
  String? transactionCategoryValue;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    transactionTypeController.dispose();
    transactionCategoryController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BigHeader(context, 'Add transaction'),
            Positioned(
              top: 120,
              left: 20,
              right: 20,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.08),
                        offset: Offset(0, 22),
                        blurRadius: 35,
                      ),
                    ],
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                  child: Column(
                    children: [
                      InputDecorator(
                        decoration: InputDecoration(
                            fillColor: const Color(0xFFC4C4C4).withAlpha(30),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text('Transaction Type'),
                          value: transactionTypeValue,
                          underline: const SizedBox(),
                          onChanged: (String? value) {
                            setState(() {
                              transactionTypeValue = value ?? "";
                              transactionTypeController.text = transactionTypeValue!;
                            });
                          },
                          items: transactionType.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      MyTextField(hintText: 'Title', controller: titleController, obscureText: false, inputType: TextInputType.text,),
                      const SizedBox(height: 20,),
                      MyTextField(hintText: 'Description', controller: descriptionController, obscureText: false, inputType: TextInputType.text,),
                      const SizedBox(height: 20,),
                      MyTextField(hintText: 'Amount', controller: amountController, obscureText: false, inputType: TextInputType.number,),
                      const SizedBox(height: 20,),
                      InputDecorator(
                        decoration: InputDecoration(
                          fillColor: const Color(0xFFC4C4C4).withAlpha(30),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: transactionTypeController.text == 'Expense' || transactionTypeController.text.isEmpty ? const Text('Expense Category') : const Text('Income, no Category'),
                          value: transactionCategoryValue,
                          underline: const SizedBox(),
                          onChanged: transactionTypeController.text == 'Expense' ? (String? value) {
                            setState(() {
                              transactionCategoryValue = value ?? "";
                              transactionCategoryController.text = transactionCategoryValue!;
                            });
                          } : null,
                          items: transactionCategory.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      MyTextField(
                        hintText: transactionTypeController.text == 'Expense' || transactionTypeController.text.isEmpty ? 'Name of Budget (case sensitive)' : 'No need to fill Budget',
                        controller: budgetController,
                        obscureText: false,
                        inputType: TextInputType.text,
                        readOnly: transactionTypeController.text == 'Expense' || transactionTypeController.text.isEmpty ? null : true
                      ),
                      const SizedBox(height: 20),
                      MyButton(
                        text: 'Save',
                        onTap: () {
                          if (titleController.text.isEmpty || amountController.text.isEmpty || transactionTypeController.text.isEmpty) {
                            displayPopupMessage('Please fill in the blanks', context);
                          } else if (transactionTypeController.text == 'Expense' && transactionCategoryController.text.isEmpty) {
                            displayPopupMessage('Fill the category', context);
                          } else {
                            MyDatabase().addTransactionToDb(
                              titleController.text,
                              descriptionController.text,
                              double.parse(amountController.text),
                              transactionTypeController.text,
                              transactionCategoryController.text,
                              budgetController.text
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}