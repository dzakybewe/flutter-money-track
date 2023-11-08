import 'package:flutter/material.dart';

import 'colors.dart';

class MyWalletInfo extends StatelessWidget {
  const MyWalletInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 150,
      width: 320,
      decoration: BoxDecoration(
        color: appSecondary,
        borderRadius: BorderRadius.circular(20),
      ),

      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Balance', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),),
                  SizedBox(height: 5,),
                  Text('Rp200.000.000.000.000', style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),

          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Income
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Income', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5,),
                  Text('Rp2.500.000', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              ),

              // Expense
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Expenses', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),
                  Text('Rp25.000', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600)),
                ],
              )
            ],
          )


        ],
      ),
    );
  }
}
