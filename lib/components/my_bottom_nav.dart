import 'package:flutter/material.dart';
import 'package:flutter_money_track/components/colors.dart';

class MyBottomNav extends StatelessWidget {
  final int selectedIndex;
  ValueChanged<int> onClickedBottomNav;

  MyBottomNav(
      {super.key,
      required this.selectedIndex,
      required this.onClickedBottomNav});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedFontSize: 13,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'Home',
            activeIcon: Icon(Icons.home)
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.payments_outlined,
            ),
            label: 'Transaction',
            activeIcon: Icon(Icons.payments)
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.notification_important_outlined,
          ),
          label: 'Bills',
          activeIcon: Icon(Icons.notification_important)
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.savings_outlined,
            ),
            label: 'Budget',
            activeIcon: Icon(Icons.savings)
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Profile',
            activeIcon: Icon(Icons.person)
        ),
      ],

      currentIndex: selectedIndex,
      onTap: onClickedBottomNav,
      selectedItemColor: appPrimary,
      // onTap: (int index) {
      //   setState(() {
      //
      //   });
      //   // switch (index) {
      //   //   case 0 : Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      //   //   case 1 : Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage()));
      //   //   case 2 : Navigator.push(context, MaterialPageRoute(builder: (context) => BillsPage()));
      //   //   case 3 : Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetPage()));
      //   // }
      // },
    );
  }
}
