import 'package:flutter/material.dart';

import '../../services/api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EmployerManageJobsScreen
    extends StatefulWidget {

  const EmployerManageJobsScreen({
    super.key,
  });

  @override
  State<EmployerManageJobsScreen>
      createState() =>
          _EmployerManageJobsScreenState();
}

class _EmployerManageJobsScreenState
    extends State<EmployerManageJobsScreen> {

  final ApiService apiService =
      ApiService();

  List jobs = [];

  bool isLoading = true;

  Future<void> fetchJobs() async {

    try {

      SharedPreferences prefs =

          await SharedPreferences
              .getInstance();

      int employerId =

          prefs.getInt(
            "userId",
          ) ??

          0;

      final response =

          await apiService
              .getEmployerJobs(
        employerId: employerId,
      );

      setState(() {

        jobs = response.data;

        isLoading = false;
      });

    } catch (e) {

      print(
        "FETCH JOB ERROR: $e",
      );

      setState(() {

        isLoading = false;
      });
    }
  }

  Future<void> deleteJob(
      int jobId) async {

    try {

      await apiService.deleteJob(
        jobId: jobId,
      );

      SharedPreferences prefs =

          await SharedPreferences
              .getInstance();

      int currentJobs =

          prefs.getInt(
                "activeJobsCount",
              ) ??

              0;

      if (currentJobs > 0) {

        await prefs.setInt(

          "activeJobsCount",

          currentJobs - 1,
        );
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Job Deleted Successfully",
          ),
        ),
      );

      fetchJobs();

    } catch (e) {

      print(
        "DELETE ERROR: $e",
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Failed To Delete Job",
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

          : jobs.isEmpty

              ? const Center(
                  child: Text(
                    "No Jobs Posted Yet",
                  ),
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

                      decoration:
                          BoxDecoration(

                        color:
                            const Color(
                          0xFF1A1333,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          24,
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                                Colors
                                    .deepPurple
                                    .withOpacity(
                                      0.4,
                                    ),

                            blurRadius:
                                12,

                            offset:
                                const Offset(
                              0,
                              6,
                            ),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            job["title"] ??
                                "",

                            style:
                                const TextStyle(

                              color:
                                  Colors.white,

                              fontSize: 22,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                              height: 10),

                          Text(

                            "Company: ${job["company"]}",

                            style:
                                const TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),

                          const SizedBox(
                              height: 5),

                          Text(

                            "Location: ${job["location"]}",

                            style:
                                const TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),

                          const SizedBox(
                              height: 5),

                          Text(

                            "Salary: ${job["salary"]}",

                            style:
                                const TextStyle(

                              color:
                                  Color(
                                0xFF4FD1C5,
                              ),

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                              height: 20),

                          SizedBox(

                            width:
                                double.infinity,

                            child:
                                ElevatedButton(

                              style:
                                  ElevatedButton.styleFrom(

                                backgroundColor:
                                    Colors.red,
                              ),

                              onPressed: () {

                                deleteJob(
                                  job["id"],
                                );
                              },

                              child:
                                  const Text(
                                "Delete Job",
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