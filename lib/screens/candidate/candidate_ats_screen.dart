import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';

class CandidateATSScreen extends StatefulWidget {
  const CandidateATSScreen({super.key});

  @override
  State<CandidateATSScreen> createState() =>
      _CandidateATSScreenState();
}

class _CandidateATSScreenState
    extends State<CandidateATSScreen> {



  File? resumeFile;

  bool analysisDone = false;

  int atsScore = 0;

  List<String> matchedSkills = [];

  List<String> missingSkills = [];

  final ApiService apiService =
    ApiService();

  Future<void> pickResume() async {

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );

    if (result != null) {

      setState(() {
        resumeFile = File(
          result.files.single.path!,
        );
      });

    }
  }

    Future<void> analyzeResume() async {

        if (resumeFile == null) {

            ScaffoldMessenger.of(context)
                .showSnackBar(

            const SnackBar(
                content: Text(
                "Please upload resume",
                ),
            ),
            );

            return;
        }

        try {

            Response response =
                await apiService.scanATSResume(
            resumeFile: resumeFile!,
            );

            print(response.data);

            setState(() {

            atsScore =
                response.data["score"] ?? 0;

            matchedSkills =
                List<String>.from(
                response.data["matchedSkills"]
                    ?? [],
            );

            missingSkills =
                List<String>.from(
                response.data["missingSkills"]
                    ?? [],
            );

            analysisDone = true;
            });

        } catch (e) {

            print("ATS ERROR: $e");

            ScaffoldMessenger.of(context)
                .showSnackBar(

            const SnackBar(
                content: Text(
                "ATS Scan Failed",
                ),
            ),
            );
        }
        }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "ATS Resume Checker",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const SizedBox(height: 20),

            GestureDetector(

              onTap: () {
                pickResume();
              },

              child: Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(18),

                decoration: BoxDecoration(

                  border: Border.all(
                    color: Colors.grey,
                  ),

                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: Text(

                  resumeFile != null

                      ? "Resume Uploaded"

                      : "Upload Resume PDF",
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  if (resumeFile == null) {

                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          "Please upload resume",
                        ),
                      ),
                    );

                    return;
                  }

                  analyzeResume();
                },

                child: const Text(
                  "Analyze Resume",
                ),
              ),
            ),

            const SizedBox(height: 40),

            if (analysisDone)

              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "ATS Score: $atsScore%",

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Matched Skills",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ...matchedSkills.map(

                    (skill) => ListTile(

                      leading: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),

                      title: Text(skill),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Missing Skills",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  ...missingSkills.map(

                    (skill) => ListTile(

                      leading: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),

                      title: Text(skill),
                    ),
                  ),

                ],
              ),

          ],
        ),
      ),
    );
  }
}