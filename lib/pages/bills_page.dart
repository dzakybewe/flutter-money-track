import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/mini_header_background.dart';
import 'package:flutter_money_track/components/mini_header_content.dart';

class BillsPage extends StatelessWidget {
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MiniHeaderBackground(),
        MiniHeaderContent(title: 'Bills Reminder'),
      ],
    );
  }
}
