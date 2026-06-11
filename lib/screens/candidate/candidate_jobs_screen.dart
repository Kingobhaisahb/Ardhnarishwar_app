import 'package:flutter/material.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CandidateJobsScreen
    extends StatefulWidget {

  const CandidateJobsScreen({
    super.key,
  });

  @override
  State<CandidateJobsScreen>
      createState() =>
          _CandidateJobsScreenState();
}

class _CandidateJobsScreenState
    extends State<CandidateJobsScreen> {

  final ApiService apiService =
      ApiService();

  List jobs = [];

  List<int> appliedJobIds = [];

  bool isLoading = true;

  Future<void> fetchJobs() async {

    try {

      SharedPreferences prefs =

          await SharedPreferences
              .getInstance();

      List<String> appliedJobs =

          prefs.getStringList(
                "appliedJobs",
              ) ??

              [];

      appliedJobIds =

          appliedJobs
              .map(
                (e) => int.parse(e),
              )
              .toList();

      Response response =

          await apiService.getJobs();

      print(response.data);

      setState(() {

        jobs = response.data;

        isLoading = false;
      });

    } catch (e) {

      print("JOB ERROR: $e");

      setState(() {

        isLoading = false;
      });
    }
  }

  Future<void> applyForJob(

    int jobId,

    String title,

    String company,

  ) async {

    try {

      SharedPreferences prefs =

          await SharedPreferences
              .getInstance();

      int? userId =
          prefs.getInt("userId");

      if (userId == null) {
        return;
      }

      Response response =

          await apiService.applyJob(

        candidateId: userId,

        jobId: jobId,
      );

      print(response.data);

      int currentCount =

          prefs.getInt(
                "appliedJobsCount",
              ) ??

              0;

      await prefs.setInt(

        "appliedJobsCount",

        currentCount + 1,
      );

      List<String> applicationsList =

          prefs.getStringList(
                "applicationsList",
              ) ??

              [];

      String applicationData =

          "$userId|"

          "$jobId|"

          "$title|"

          "$company";

      applicationsList.add(
          applicationData);

      await prefs.setStringList(

        "applicationsList",

        applicationsList,
      );

      List<String> appliedJobs =

          prefs.getStringList(
                "appliedJobs",
              ) ??

              [];

      appliedJobs.add(
          jobId.toString());

      await prefs.setStringList(

        "appliedJobs",

        appliedJobs,
      );

      setState(() {

        appliedJobIds.add(jobId);
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Applied Successfully",
          ),
        ),
      );

    } catch (e) {

      print("APPLY ERROR: $e");

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Application Failed",
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    fetchJobs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : ListView.builder(

              itemCount:
                  jobs.length,

              itemBuilder:
                  (context, index) {

                final job =
                    jobs[index];

                return Container(

                  margin:
                      const EdgeInsets.all(
                    12,
                  ),

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

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
                        CrossAxisAlignment
                            .start,

                    children: [

                      Text(

                        job["title"] ??
                            "No Title",

                        style:
                            const TextStyle(
                          fontSize: 22,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      Text(
                        "Company: ${job["company"] ?? "N/A"}",
                      ),

                      const SizedBox(
                          height: 5),

                      Text(
                        "Location: ${job["location"] ?? "N/A"}",
                      ),

                      const SizedBox(
                          height: 5),

                      Text(
                        "Salary: ${job["salary"] ?? "N/A"}",
                      ),

                      const SizedBox(
                          height: 20),

                      SizedBox(

                        width:
                            double.infinity,

                        child:
                            ElevatedButton(

                          onPressed:

                              appliedJobIds.contains(
                                      job["id"])

                                  ? null

                                  : () {

                                      applyForJob(

                                        job["id"],

                                        job["title"],

                                        job["company"],
                                      );
                                    },

                          child: Text(

                            appliedJobIds.contains(
                                    job["id"])

                                ? "Applied"

                                : "Apply Now",
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}