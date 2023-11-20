import 'package:flutter/material.dart';

import '../components/mini_header_background.dart';
import '../components/mini_header_content.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Wahyu Doong Kie';
  String email = 'WahyuDoongKie@gmail.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MiniHeaderBackground(),
          MiniHeaderContent(title: 'Profile'),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 120, right: 15),
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
                            image: DecorationImage(
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
                  SizedBox(height: 20),
                  UserInfo(
                    name: name,
                    email: email,
                    onEditPressed: () async {
                      // Navigate to the edit profile page and wait for the result
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            initialName: name,
                            initialEmail: email,
                          ),
                        ),
                      );

                      // Update the profile data if the result is not null
                      if (result != null && result is Map<String, String>) {
                        setState(() {
                          name = result['name']!;
                          email = result['email']!;
                        });
                      }
                    },
                    onSignOutPressed: () {
                      // Implement your sign-out logic here
                      // For example, you can use Firebase or any other authentication service to sign out the user
                      // After signing out, you can navigate to the login page or perform any other necessary actions
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

class EditProfilePage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;

  EditProfilePage({required String initialName, required String initialEmail})
      : nameController = TextEditingController(text: initialName),
        emailController = TextEditingController(text: initialEmail);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MiniHeaderBackground(),
          MiniHeaderContent(title: 'Edit Profile'),
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
                            image: DecorationImage(
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
                  SizedBox(height: 20),
                  EditProfileForm(
                    nameController: nameController,
                    emailController: emailController,
                    onSavePressed: () {
                      // Save the edited profile details
                      // You can implement the logic to update the profile here

                      // Pass the edited data back to the ProfilePage
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

  EditProfileForm({
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
          controller: nameController,
          decoration: InputDecoration(labelText: 'Edit Name'),
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: 'Edit Email'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: onSavePressed,
          child: Text('Save'),
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

  UserInfo({
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.edit, size: 20),
              onPressed: onEditPressed,
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          email,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: onSignOutPressed,
          icon: Icon(Icons.exit_to_app),
          label: Text('Sign Out'),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.red,
          ),
        ),
      ],
    );
  }
}