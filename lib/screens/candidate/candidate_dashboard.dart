import 'package:flutter/material.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CandidateDashboard
    extends StatefulWidget {

  const CandidateDashboard({
    super.key,
  });

  @override
  State<CandidateDashboard>
      createState() =>
          _CandidateDashboardState();
}

class _CandidateDashboardState
    extends State<CandidateDashboard> {

  final ApiService apiService =
      ApiService();

  int totalJobs = 0;

  bool isLoading = true;

  bool profileCompleted = false;

  int appliedJobsCount = 0;

  bool resumeUploaded = false;

  List jobs = [];

  Future<void> fetchJobsCount() async {

    try {

      Response response =
          await apiService.getJobs();

      setState(() {

        totalJobs =
            response.data.length;

        jobs = response.data;

        isLoading = false;
      });

    } catch (e) {

      print("DASHBOARD ERROR: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadProfileStatus() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    setState(() {

      profileCompleted =
          prefs.getBool(
                "profileCompleted",
              ) ??
              false;
    });
  }

  Future<void> loadAppliedJobsCount() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    setState(() {

      appliedJobsCount =
          prefs.getInt(
                "appliedJobsCount",
              ) ??
              0;
    });
  }

  Future<void> loadResumeStatus() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    setState(() {

      resumeUploaded =
          prefs.getBool(
                "resumeUploaded",
              ) ??
              false;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchJobsCount();

    loadProfileStatus();

    loadAppliedJobsCount();

    loadResumeStatus();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Padding(

        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Welcome Back",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            IntrinsicHeight(
              child: Row(
                children: [

                dashboardCard(

                  title: isLoading
                      ? "..."
                      : totalJobs.toString(),

                  subtitle: "Total Jobs",
                ),

                const SizedBox(width: 10),

                dashboardCard(

                  title:
                      appliedJobsCount.toString(),

                  subtitle: "Applied Jobs",
                ),

              ],
            ),
          ),

            const SizedBox(height: 10),

            Row(
              children: [

                dashboardCard(

                  title: profileCompleted
                      ? "Complete"
                      : "Incomplete",

                  subtitle: "Profile Status",
                ),

                const SizedBox(width: 10),

                dashboardCard(

                  title: resumeUploaded
                      ? "Uploaded"
                      : "Not Uploaded",

                  subtitle: "Resume",
                ),

              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Latest Opportunities",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 15),

            ListView.builder(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemCount:
                  jobs.length > 3
                      ? 3
                      : jobs.length,

              itemBuilder: (context, index) {

                final job = jobs[index];

                return Padding(

                  padding:
                      const EdgeInsets.only(
                    bottom: 15,
                  ),

                  child: latestJobCard(

                    title:
                        job["title"] ?? "",

                    company:
                        job["company"] ?? "",

                    location:
                        job["location"] ?? "",
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }

  Widget dashboardCard({
    required String title,
    required String subtitle,
  }) {

    return Expanded(

      child: Container(

        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(

          color: const Color(0xFF141122),

          borderRadius:
              BorderRadius.circular(15),

          boxShadow: [],
        ),

        child: Column(

          mainAxisSize: MainAxisSize.min,

          children: [

            FittedBox(

              child: Text(

                title,

                style: const TextStyle(

                  fontSize: 22,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Color(0xFF6C3BFF),
                ),
              ),
            ),

            const SizedBox(height: 5),

            Text(

              subtitle,

              textAlign: TextAlign.center,

              style: const TextStyle(

                color: Colors.white70,

                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget latestJobCard({
    required String title,
    required String company,
    required String location,
  }) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: const Color(
          0xFF141122,
        ),

        borderRadius:
            BorderRadius.circular(
          20,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            title,

            style: const TextStyle(

              color: Colors.white,

              fontSize: 20,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(

            "Company: $company",

            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            "Location: $location",
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),

        ],
      ),
    );
  }
}