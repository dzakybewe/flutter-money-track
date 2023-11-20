import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/mini_header.dart';


class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            MiniHeader(title: 'Budget',),
          ],
        ),
        /// Lanjutin Kode dibawah sini biar ga numpuk di header

      ],
    );
  }
}
