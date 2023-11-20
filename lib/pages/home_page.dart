import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/components/colors.dart';
import 'package:flutter_money_track/components/my_wallet_info.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Authentication().currentUser;

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  List<BarChartGroupData> getWeeklyBarGroups() {
    // Implement logic to get weekly transaction data
    // Example data (replace it with your actual data)
    return List.generate(
      7,
          (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            width: 16,
            toY: 10.0, // Replace with your actual value
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: MyDatabase().getUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                Stack(
                  children: [
                    // Background
                    Container(
                      height: 240,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: appPrimaryGradient,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                      ),
                    ),

                    SafeArea(
                      child: Column(
                        children: [
                          //// Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 30, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Hello,', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
                                    Text(user['username'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30, right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Container(
                                    color: appSecondary,
                                    child: IconButton(
                                      onPressed: signOut,
                                      icon: const Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //// End Header

                          const SizedBox(height: 30),
                          //// balance info
                          MyWalletInfo(),

                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ],
                ),
                /// Lanjutin kode dibawah sini biar ga numpuk
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius : BorderRadius.circular(10),
                                color: appPrimary
                            ),
                            child: Text(
                              'Week',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text('Month'),
                          Text('Year'),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text(
                          'Statistics',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),

                      //Bar chart
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                            ),
                            borderData: FlBorderData(show: true),
                            barGroups: getWeeklyBarGroups(),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );

          } else {
            return Text('No data');
          }
        }
    );
  }
}