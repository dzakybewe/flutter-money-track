import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/my_bottom_nav.dart';
import 'package:flutter_money_track/pages/bills_page.dart';
import 'package:flutter_money_track/pages/budget_page.dart';
import 'package:flutter_money_track/pages/home_page.dart';
import 'package:flutter_money_track/pages/profile_page.dart';
import 'package:flutter_money_track/pages/transaction_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int selectedIndex = 0;
  List pages = [
    HomePage(),
    TransactionPage(),
    BillsPage(),
    BudgetPage(),
    ProfilePage(),
  ];

  void onClickedBottomNav(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(selectedIndex),
      bottomNavigationBar: MyBottomNav(
        selectedIndex: selectedIndex,
        onClickedBottomNav: onClickedBottomNav,
      ),

    );
  }
}
