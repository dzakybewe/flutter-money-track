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
var transactionCategory = ['Shopping', 'Groceries', 'Foods', 'Entertainment'];

class _NewTransactionPageState extends State<NewTransactionPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final transactionTypeController = TextEditingController();
  final transactionCategoryController = TextEditingController();



  String? transactionTypeValue;
  String? transactionCategoryValue;

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
              child: Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.08),
                        offset: const Offset(0, 22),
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
                                borderSide: BorderSide.none
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text('Transaction Type'),
                          value: transactionTypeValue,
                          underline: SizedBox(),
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
                      SizedBox(height: 20,),
                      MyTextField(hintText: 'Title', controller: titleController, obscureText: false, inputType: TextInputType.text,),
                      SizedBox(height: 20,),
                      MyTextField(hintText: 'Description', controller: descriptionController, obscureText: false, inputType: TextInputType.text,),
                      SizedBox(height: 20,),
                      MyTextField(hintText: 'Amount', controller: amountController, obscureText: false, inputType: TextInputType.number,),
                      SizedBox(height: 20,),
                      InputDecorator(
                        decoration: InputDecoration(
                            fillColor: const Color(0xFFC4C4C4).withAlpha(30),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text('Transaction Type'),
                          value: transactionCategoryValue,
                          underline: SizedBox(),
                          onChanged: (String? value) {
                            setState(() {
                              transactionCategoryValue = value ?? "";
                              transactionCategoryController.text = transactionCategoryValue!;
                            });
                          },
                          items: transactionCategory.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      MyButton(
                        text: 'Save',
                        onTap: () {
                          if (titleController.text.isEmpty) {
                            displayPopupMessage('Fill the title', context);
                          } else if (amountController.text.isEmpty) {
                            displayPopupMessage('Fill the amount', context);
                          } else if (transactionTypeController.text.isEmpty){
                            displayPopupMessage('Is it income or expense?', context);
                          } else if (transactionCategoryController.text.isEmpty) {
                            displayPopupMessage('Fill the category', context);
                          } else {
                            MyDatabase().addTransactionToDb(
                                titleController.text,
                                descriptionController.text,
                                double.parse(amountController.text),
                                transactionTypeController.text,
                                transactionCategoryController.text
                            );
                            Navigator.pop(context);
                          }
                        }
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}