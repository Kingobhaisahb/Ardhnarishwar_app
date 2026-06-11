import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';

import 'employer_dashboard.dart';

import 'employer_post_jobs_screen.dart';

import 'employer_manage_jobs_screen.dart';

import 'employer_applicants_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class EmployerHomeScreen
    extends StatefulWidget {

  const EmployerHomeScreen({
    super.key,
  });

  @override
  State<EmployerHomeScreen>
      createState() =>
          _EmployerHomeScreenState();
}

class _EmployerHomeScreenState
    extends State<EmployerHomeScreen> {

  int selectedIndex = 0;

  final List pages = [

    const EmployerDashboard(),

    const EmployerPostJobsScreen(),

    const EmployerManageJobsScreen(),

    const EmployerApplicantsScreen(),
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

  Future<void> openDeleteDialog() async {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(

        title: const Text("Delete Account"),

        content: const Text(
          "To request account deletion, please visit our account deletion page.\n\n"
          "Your account and associated data will be permanently deleted within 30 days of verification."
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () async {

              final Uri url = Uri.parse(
                "https://sites.google.com/view/ardhnarishwaradeletion/home"
              );

              await launchUrl(
                url,
                mode: LaunchMode.externalApplication,
              );

              Navigator.pop(context);
            },
            child: const Text("Open Page"),
          ),
        ],
      ),
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
          "Ardhnarishwar Employer",
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

              decoration:
                  const BoxDecoration(

                color: Color(
                  0xFF1A1333,
                ),
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

                  const SizedBox(
                      height: 8),

                  const Text(

                    "Ardhnarishwar",

                    style: TextStyle(

                      color:
                          Colors.white,

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 5),

                  const Text(

                    "Talent Meets Opportunity",

                    style: TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            drawerItem(
              icon: Icons.dashboard,
              title: "Dashboard",
              index: 0,
            ),

            drawerItem(
              icon: Icons.add_box,
              title: "Post Job",
              index: 1,
            ),

            drawerItem(
              icon: Icons.work,
              title: "Manage Jobs",
              index: 2,
            ),

            drawerItem(
              icon: Icons.people,
              title: "Applicants",
              index: 3,
            ),

            drawerItem(
              icon: Icons.delete_forever,
              title: "Delete Account",
              index: 4,
            ),

            drawerItem(
              icon: Icons.logout,
              title: "Logout",
              index: 5,
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

        if (index == 4) {

          openDeleteDialog();

          return;
        }

        if (index == 5) {

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