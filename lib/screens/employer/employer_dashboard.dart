import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';

class EmployerDashboard
    extends StatefulWidget {

  const EmployerDashboard({
    super.key,
  });

  @override
  State<EmployerDashboard>
      createState() =>
          _EmployerDashboardState();
}

class _EmployerDashboardState
    extends State<EmployerDashboard> {

  final ApiService apiService =
      ApiService();

  int totalJobs = 0;

  int totalCandidates = 0;

  int activeJobs = 0;

  List employerJobs = [];

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

      int employerId =
          prefs.getInt("userId") ?? 0;

      List<String> usersList =

          prefs.getStringList(
                "usersList",
              ) ??

              [];

      int candidateCount = 0;

      for (String user in usersList) {

        List<String> parts =
            user.split("|");

        if (parts[2] ==
            "CANDIDATE") {

          candidateCount++;
        }
      }

      Response allJobsResponse =
          await apiService.getJobs();

      print(
        "EMPLOYER ID: $employerId",
      );

      Response employerJobsResponse =

          await apiService
              .getEmployerJobs(
        employerId: employerId,
      );

      print(
        employerJobsResponse.data,
      );

      setState(() {

        totalJobs =
            allJobsResponse
                .data
                .length;

        totalCandidates =
            candidateCount;

        activeJobs =

            prefs.getInt(
              "activeJobsCount",
            ) ??

            0;

        employerJobs =
            employerJobsResponse
                .data;

        isLoading = false;
      });

      print(
        employerJobsResponse.data,
      );

    } catch (e) {

      print(
        "EMPLOYER DASHBOARD ERROR: $e",
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
              BorderRadius.circular(20),

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
            ),
          ],
        ),
      ),
    );
  }

  Widget latestJobCard({
    required String title,
    required String location,
  }) {

    return Container(

      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      padding:
          const EdgeInsets.all(15),

      decoration: BoxDecoration(

        color: const Color(0xFF141122),

        borderRadius:
            BorderRadius.circular(20),

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
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(location),
        ],
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

          : SingleChildScrollView(

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
                    "Welcome Back",

                    style: TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 25),

                  Row(
                    children: [

                      dashboardCard(
                        title:
                            "$totalJobs",

                        subtitle:
                            "Total Jobs Posted",
                      ),

                      dashboardCard(
                        title:
                            "$totalCandidates",

                        subtitle:
                            "Total Applicants",
                      ),

                    ],
                  ),

                  const SizedBox(
                      height: 15),

                  Row(
                    children: [

                      dashboardCard(
                        title:
                            "$activeJobs",

                        subtitle:
                            "Active Jobs",
                      ),

                      dashboardCard(
                        title:
                            "AI Enabled",

                        subtitle:
                            "Smart Hiring",
                      ),

                    ],
                  ),

                  const SizedBox(
                      height: 30),

                  const Text(
                    "Recent Posted Jobs",

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  ListView.builder(

                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount:
                        employerJobs.length,

                    itemBuilder:
                        (context, index) {

                      final job =
                          employerJobs[index];

                      return latestJobCard(

                        title:
                            job["title"] ?? "",

                        location:
                            job["location"] ?? "",
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}