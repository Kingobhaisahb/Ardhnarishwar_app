import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';

import 'admin_dashboard.dart';

import 'admin_jobs_screen.dart';

import 'admin_users_screen.dart';

class AdminHomeScreen
    extends StatefulWidget {

  const AdminHomeScreen({
    super.key,
  });

  @override
  State<AdminHomeScreen>
      createState() =>
          _AdminHomeScreenState();
}

class _AdminHomeScreenState
    extends State<AdminHomeScreen> {

  int selectedIndex = 0;

  final List pages = [

    const AdminDashboard(),

    const AdminUsersScreen(),

    const AdminJobsScreen(),
  ];

  Future<void> logoutUser() async {

    SharedPreferences prefs =

        await SharedPreferences
            .getInstance();

    await prefs.clear();

    Navigator.pushAndRemoveUntil(

      context,

      MaterialPageRoute(

        builder: (context) =>

            const LoginScreen(),
      ),

      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(
        0xFF0F0B1E,
      ),

      appBar: AppBar(

        backgroundColor:
            const Color(
          0xFF1A1333,
        ),

        title: const Text(
          "Ardhnarishwar Admin",
        ),
      ),

      drawer: Drawer(

        backgroundColor:
            const Color(
          0xFF161026,
        ),

        child: ListView(

          children: [

            DrawerHeader(

              margin: EdgeInsets.zero,

              decoration: const BoxDecoration(
                color: Color(0xFF1A1333),
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const CircleAvatar(

                    radius: 30,

                    backgroundImage:
                        AssetImage(
                      "assets/images/logo.png",
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(

                    "Ardhnarishwar",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(

                    "Talent Meets Opportunity",

                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            drawerItem(

              icon:
                  Icons.dashboard,

              title:
                  "Dashboard",

              index: 0,
            ),

            drawerItem(

              icon:
                  Icons.people,

              title:
                  "Users",

              index: 1,
            ),

            drawerItem(

              icon:
                  Icons.work,

              title:
                  "Jobs",

              index: 2,
            ),

            drawerItem(

              icon:
                  Icons.logout,

              title:
                  "Logout",

              index: 3,
            ),
          ],
        ),
      ),

      body: Container(

        color: const Color(
          0xFF0F0B1E,
        ),

        child:
            pages[selectedIndex],
      ),
    );
  }

  Widget drawerItem({

    required IconData icon,

    required String title,

    required int index,

  }) {

    return ListTile(

      leading: Icon(

        icon,

        color: const Color(0xFF6C3BFF),
      ),

      title: Text(

        title,

        style: const TextStyle(
          color: const Color(0xFF6C3BFF),
        ),
      ),

      onTap: () {

        Navigator.pop(context);

        if (index == 3) {

          logoutUser();

          return;
        }

        setState(() {

          selectedIndex = index;
        });
      },
    );
  }
}