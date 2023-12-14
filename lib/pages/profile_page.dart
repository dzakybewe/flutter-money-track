import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_track/auth/authentication.dart';
import '../auth/my_database.dart';
import '../components/mini_header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: MyDatabase().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text('Loading'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const MiniHeader(title: 'Profile', backIcon: true, rightIcon: false,),
                Center(
                    child: Text('Error: ${snapshot.error}')
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              children: [
                const MiniHeader(title: 'Profile', backIcon: true, rightIcon: false,),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 120, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 4, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2014/04/13/20/49/cat-323262_1280.jpg',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        UserInfo(
                          name: data['username'],
                          email: data['email'],
                          onEditPressed: () {
                            showDialog(context: context, builder: (context){
                              return const AlertDialog(
                                title: Text('This feature will come soon!', textAlign: TextAlign.center,),
                                content: Text('Stay Tuned!', textAlign: TextAlign.center,),
                              );
                            });
                          },
                          onSignOutPressed: () {
                            Authentication().signOut();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data', style: TextStyle(color: Colors.black),));
          }
        },
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;

  EditProfilePage({super.key, required String initialName, required String initialEmail})
      : nameController = TextEditingController(text: initialName),
        emailController = TextEditingController(text: initialEmail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MiniHeader(title: 'Edit Profile', backIcon: true, rightIcon: false,),
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 15, right: 15),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                              )
                            ],
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2014/04/13/20/49/cat-323262_1280.jpg',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  EditProfileForm(
                    nameController: nameController,
                    emailController: emailController,
                    onSavePressed: () {
                      Navigator.pop(
                        context,
                        {
                          'name': nameController.text,
                          'email': emailController.text,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onSavePressed;

  const EditProfileForm({super.key, 
    required this.nameController,
    required this.emailController,
    required this.onSavePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: true,
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Edit Name'),
        ),
        TextField(
          readOnly: true,
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Edit Email'),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: onSavePressed,
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class UserInfo extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onEditPressed;
  final VoidCallback onSignOutPressed;

  const UserInfo({
    super.key,
    required this.name,
    required this.email,
    required this.onEditPressed,
    required this.onSignOutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: onEditPressed,
            ),
          ],
        ),
        Text(
          email,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          onPressed: onSignOutPressed,
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Sign Out'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
