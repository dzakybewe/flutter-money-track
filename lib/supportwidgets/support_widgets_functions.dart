import 'package:flutter/material.dart';

void displayPopupMessage(String message, BuildContext context){
  const style = TextStyle(
    color: Colors.red
  );
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message, style: style),
    )
  );
}

void confirmDelete(BuildContext context, VoidCallback action) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      elevation: 0.0,
      title: Center(
        child: Column(
          children: [
            const Text(
              'Sure you want to delete?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20
              ),
            ),
            const SizedBox(height: 10,),
            Text(
              'Are you sure you want to delete this?',
              style: TextStyle(
                color: const Color(0xFF54595E).withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                width: 1
              )
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'No, cancel',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide.none
            ),
            color: Colors.red,
            onPressed: action,
            child: const Text(
              'Yes, delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    ),
  );
}