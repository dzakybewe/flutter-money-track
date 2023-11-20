import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/save_delete_button.dart';

class DialogBox extends StatelessWidget {
  final titleController;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({super.key, required this.titleController, required this.onSave, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(),
                  hintText: 'new task',
                  hintStyle: TextStyle(color: Colors.grey,)
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SaveDeleteButton(text: 'Save', onPressed: onSave),
                SaveDeleteButton(text: 'Cancel', onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
