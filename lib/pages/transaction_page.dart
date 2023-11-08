import 'package:flutter/material.dart';
import '../components/mini_header_background.dart';
import '../components/mini_header_content.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MiniHeaderBackground(),
        MiniHeaderContent(title: 'Transaction'),
      ],
    );
  }
}
