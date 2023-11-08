import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/mini_header_background.dart';
import '../components/mini_header_content.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MiniHeaderBackground(),
        MiniHeaderContent(title: 'Budget'),
      ],
    );
  }
}
