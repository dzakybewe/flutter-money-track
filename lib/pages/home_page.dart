import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import 'package:flutter_money_track/components/colors.dart';
import 'package:flutter_money_track/components/my_list_tile.dart';
import 'package:flutter_money_track/components/my_wallet_info.dart';
import 'package:flutter_money_track/components/my_button.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = Authentication().currentUser;

  Future<void> signOut() async {
    await Authentication().signOut();
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return MyButton(
      onTap: signOut,
      text: 'Sign Out',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    const Padding(
                      padding: EdgeInsets.only(top: 30, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hello,', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),),
                          Text('Dzaky Ahmadin BW', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
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

                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transactions History',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //// ListView transaction
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return MyListTile();
                        }
                    )
                ),
              ],
            ),
          ),

        ],
      );
  }
}
