import 'package:flutter/material.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';

class AdminJobsScreen
    extends StatefulWidget {

  const AdminJobsScreen({
    super.key,
  });

  @override
  State<AdminJobsScreen>
      createState() =>
          _AdminJobsScreenState();
}

class _AdminJobsScreenState
    extends State<AdminJobsScreen> {

  final ApiService apiService =
      ApiService();

  List jobs = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    fetchJobs();
  }

  Future<void> fetchJobs() async {

    try {

      Response response =
          await apiService.getJobs();

      setState(() {

        jobs = response.data;

        isLoading = false;
      });

    } catch (e) {

      print("ADMIN JOB ERROR: $e");

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

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Job Deleted",
          ),
        ),
      );

      fetchJobs();

    } catch (e) {

      print("DELETE ERROR: $e");

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
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(

        padding:
            const EdgeInsets.all(15),

        child: isLoading

            ? const Center(
                child:
                    CircularProgressIndicator(),
              )

            : jobs.isEmpty

                ? const Center(
                    child: Text(
                      "No Jobs Found",
                    ),
                  )

                : ListView.builder(

                    itemCount:
                        jobs.length,

                    itemBuilder:
                        (context, index) {

                      final job =
                          jobs[index];

                      return Card(

                        margin:
                            const EdgeInsets.only(
                          bottom: 15,
                        ),

                        child: Padding(

                          padding:
                              const EdgeInsets.all(
                            15,
                          ),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                job["title"] ?? "",

                                style:
                                    const TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                  height: 10),

                              Text(
                                "Company: ${job["company"]}",
                              ),

                              const SizedBox(
                                  height: 5),

                              Text(
                                "Location: ${job["location"]}",
                              ),

                              const SizedBox(
                                  height: 5),

                              Text(
                                "Salary: ${job["salary"]}",
                              ),

                              const SizedBox(
                                  height: 15),

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
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}