import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/auth/my_database.dart';
import 'package:flutter_money_track/components/colors.dart';
import 'package:flutter_money_track/components/my_bar_graph.dart';
import 'package:flutter_money_track/components/my_wallet_info.dart';
import 'package:flutter_money_track/pages/profile_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Authentication().currentUser;

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: MyDatabase().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Wait"),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                Stack(
                  children: [
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
                                padding: const EdgeInsets.only(top: 30, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Hello,', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
                                    Text(user['username'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
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
                                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage())),
                                      icon: const Icon(
                                        Icons.person_outline,
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
                          const MyWalletInfo(),

                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ],
                ),
                /// Lanjutin kode dibawah sini biar ga numpuk
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius : BorderRadius.circular(10),
                              color: appPrimary
                          ),
                          child: const Text(
                            'Week',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const Text('Month'),
                        const Text('Year'),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        'Statistics',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),

                    /// Graphic Chart to show weekly transaction recap
                    const MyBarGraph(),
                  ],
                ),
              ],
            );

          } else {
            return const Text('No data');
          }
        }
    );
  }
}
