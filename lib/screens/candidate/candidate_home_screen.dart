import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';

import 'candidate_dashboard.dart';

import 'candidate_jobs_screen.dart';

import 'candidate_profile_screen.dart';

import 'candidate_ats_screen.dart';

import 'candidate_cv_screen.dart';

import 'candidate_ai_chat_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class CandidateHomeScreen
    extends StatefulWidget {

  const CandidateHomeScreen({
    super.key,
  });

  @override
  State<CandidateHomeScreen>
      createState() =>
          _CandidateHomeScreenState();
}

class _CandidateHomeScreenState
    extends State<CandidateHomeScreen> {

  int selectedIndex = 0;

  final List pages = [

    const CandidateDashboard(),

    const CandidateJobsScreen(),

    const CandidateProfileScreen(),

    const CandidateATSScreen(),

    const CandidateCVScreen(),

    const CandidateAIChatScreen(),
  ];

  Future<void> logoutUser() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

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
          "Ardhnarishwar",
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

                      color: Colors.white,

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
                      color: Colors.white70,
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
              icon: Icons.work,
              title: "Jobs",
              index: 1,
            ),

            drawerItem(
              icon: Icons.person,
              title: "Profile",
              index: 2,
            ),

            drawerItem(
              icon: Icons.analytics,
              title: "ATS Checker",
              index: 3,
            ),

            drawerItem(
              icon: Icons.description,
              title: "CV Maker",
              index: 4,
            ),

            drawerItem(
              icon: Icons.smart_toy,
              title: "AI Assistant",
              index: 5,
            ),

            drawerItem(
              icon: Icons.delete_forever,
              title: "Delete Account",
              index: 6,
            ),

            drawerItem(
              icon: Icons.logout,
              title: "Logout",
              index: 7,
            ),
          ],
        ),
      ),

      body: Container(

        color: const Color(
          0xFF0F0B1E,
        ),

        child: pages[selectedIndex],
      ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            const Color(
          0xFF6C3BFF,
        ),

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(

              builder: (context) =>

                  const CandidateAIChatScreen(),
            ),
          );
        },

        child: const Icon(
          Icons.smart_toy,
          color: Colors.white,
        ),
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

        color:
            const Color(
          0xFF6C3BFF,
        ),
      ),

      title: Text(

        title,

        style: const TextStyle(

          color:
              Color(
            0xFF6C3BFF,
          ),
        ),
      ),

      onTap: () {

        Navigator.pop(context);

        if (index == 6) {

          openDeleteDialog();

          return;
        }

        if (index == 7) {

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