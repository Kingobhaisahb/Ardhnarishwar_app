import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EmployerApplicantsScreen
    extends StatefulWidget {

  const EmployerApplicantsScreen({
    super.key,
  });

  @override
  State<EmployerApplicantsScreen>
      createState() =>
          _EmployerApplicantsScreenState();
}

class _EmployerApplicantsScreenState
    extends State<EmployerApplicantsScreen> {

  List<Map<String, String>>
      applicants = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadApplicants();
  }

  Future<void> loadApplicants() async {

    SharedPreferences prefs =

        await SharedPreferences
            .getInstance();

    List<String> applicationsList =

        prefs.getStringList(
              "applicationsList",
            ) ??

            [];

    List<Map<String, String>>
        loadedApplicants = [];

    for (String application
        in applicationsList) {

      List<String> parts =
          application.split("|");

      loadedApplicants.add({

        "candidateId":
            parts[0],

        "jobId":
            parts[1],

        "title":
            parts[2],

        "company":
            parts[3],
      });
    }

    setState(() {

      applicants =
          loadedApplicants;

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : applicants.isEmpty

              ? const Center(
                  child: Text(
                    "No Applicants Yet",
                  ),
                )

              : ListView.builder(

                  itemCount:
                      applicants.length,

                  itemBuilder:
                      (context, index) {

                    final applicant =
                        applicants[index];

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

                        color: const Color(0xFF1A1333),

                        borderRadius:
                            BorderRadius.circular(
                          15,
                        ),

                        boxShadow: [

                          BoxShadow(
                            color: Colors
                                .grey
                                .shade300,

                            blurRadius: 5,
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text(

                            applicant["title"] ??
                                "",

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
                            "Company: ${applicant["company"]}",
                          ),

                          const SizedBox(
                              height: 5),

                          Text(
                            "Candidate ID: ${applicant["candidateId"]}",
                          ),

                          const SizedBox(
                              height: 5),

                          Text(
                            "Job ID: ${applicant["jobId"]}",
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}