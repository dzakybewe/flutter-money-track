import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/components/big_header.dart';
import 'package:flutter_money_track/components/my_button.dart';
import 'package:flutter_money_track/components/my_text_field.dart';
import 'package:flutter_money_track/supportwidgets/support_widgets_functions.dart';
import 'package:intl/intl.dart';

class NewBudgetPage extends StatefulWidget {
  const NewBudgetPage({super.key});

  @override
  State<NewBudgetPage> createState() => _NewBudgetPageState();
}


class _NewBudgetPageState extends State<NewBudgetPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  DateTimeRange selectedDate = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 1)));
  late DateTime startDate;
  late DateTime endDate;
  Future<void> selectDate() async {
    DateTimeRange? pickedDate = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null){
      setState(() {
        selectedDate = pickedDate;
        startDate = pickedDate.start;
        endDate = pickedDate.end;
        dateController.text = '${DateFormat('d MMM yyyy').format(startDate)}  - ${DateFormat('d MMM yyyy').format(endDate)}';
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BigHeader(context, 'Add Budget'),
            Positioned(
              top: 120,
              left: 20,
              right: 20,
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
                    MyTextField(hintText: 'Title', controller: titleController, obscureText: false, inputType: TextInputType.text,),
                    const SizedBox(height: 20,),
                    MyTextField(hintText: 'Description', controller: descriptionController, obscureText: false, inputType: TextInputType.text,),
                    const SizedBox(height: 20,),
                    MyTextField(hintText: 'Amount', controller: amountController, obscureText: false, inputType: TextInputType.number,),
                    const SizedBox(height: 20,),
                    MyTextField(
                      readOnly: true,
                      hintText: 'Time Period',
                      controller: dateController,
                      obscureText: false,
                      onTap: () => selectDate(),
                      leadingIcon: const Icon(Icons.calendar_today),
                      inputType: TextInputType.none,
                    ),
                    const SizedBox(height: 20,),
                    MyButton(
                      text: 'Save',
                      onTap: () {
                        if (titleController.text.isEmpty || amountController.text.isEmpty || dateController.text.isEmpty) {
                          displayPopupMessage('Please fill in the blanks', context);
                        } else {
                          MyDatabase().addBudgetsToDb(
                            titleController.text,
                            descriptionController.text,
                            double.parse(amountController.text),
                            startDate,
                            endDate
                          );
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}