import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';

class AdminDashboard
    extends StatefulWidget {

  const AdminDashboard({
    super.key,
  });

  @override
  State<AdminDashboard>
      createState() =>
          _AdminDashboardState();
}

class _AdminDashboardState
    extends State<AdminDashboard> {

  final ApiService apiService =
      ApiService();

  int totalUsers = 0;

  int totalCandidates = 0;

  int totalEmployers = 0;

  int totalAdmins = 0;

  int totalJobs = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadDashboardData();
  }

  Future<void> loadDashboardData() async {

    try {

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      List<String> usersList =

          prefs.getStringList(
                "usersList",
              ) ??

              [];

      int candidateCount = 0;

      int employerCount = 0;

      int adminCount = 0;

      for (String user in usersList) {

        List<String> parts =
            user.split("|");

        String role =
            parts[2];

        if (role == "CANDIDATE") {

          candidateCount++;
        }

        else if (role == "EMPLOYER") {

          employerCount++;
        }

        else if (role == "ADMIN") {

          adminCount++;
        }
      }

      Response response =
          await apiService.getJobs();

      setState(() {

        totalUsers =
            usersList.length;

        totalCandidates =
            candidateCount;

        totalEmployers =
            employerCount;

        totalAdmins =
            adminCount;

        totalJobs =
            response.data.length;

        isLoading = false;
      });

    } catch (e) {

      print(
        "ADMIN DASHBOARD ERROR: $e",
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget dashboardCard({
    required String title,
    required String subtitle,
  }) {

    return Expanded(

      child: Container(

        margin:
            const EdgeInsets.only(
          right: 10,
        ),

        padding:
            const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: const Color(0xFF141122),

          borderRadius:
              BorderRadius.circular(15),

          boxShadow: [
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              title,

              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,

                color: Color(0xFF6C3BFF),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              subtitle,

              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : Padding(

              padding:
                  const EdgeInsets.all(
                15,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const Text(
                    "Admin Dashboard",

                    style: TextStyle(
                      fontSize: 30,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  Row(
                    children: [

                      dashboardCard(
                        title:
                            "$totalUsers",

                        subtitle:
                            "Total Users",
                      ),

                      dashboardCard(
                        title:
                            "$totalCandidates",

                        subtitle:
                            "Candidates",
                      ),

                    ],
                  ),

                  const SizedBox(
                      height: 15),

                  Row(
                    children: [

                      dashboardCard(
                        title:
                            "$totalEmployers",

                        subtitle:
                            "Employers",
                      ),

                      dashboardCard(
                        title:
                            "$totalAdmins",

                        subtitle:
                            "Admins",
                      ),

                    ],
                  ),

                  const SizedBox(
                      height: 15),

                  Row(
                    children: [

                      dashboardCard(
                        title:
                            "$totalJobs",

                        subtitle:
                            "Total Jobs",
                      ),

                    ],
                  ),
                ],
              ),
            ),
    );
  }
}