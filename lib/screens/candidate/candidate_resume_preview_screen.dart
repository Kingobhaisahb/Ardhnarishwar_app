import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CandidateResumePreviewScreen
    extends StatelessWidget {

  final String fullName;
  final String designation;
  final String phone;
  final String email;
  final String location;
  final String linkedIn;
  final String summary;
  final String skills;
  final String experience;
  final String projects;
  final String education;
  final String certifications;

  const CandidateResumePreviewScreen({
    super.key,

    required this.fullName,
    required this.designation,
    required this.phone,
    required this.email,
    required this.location,
    required this.linkedIn,
    required this.summary,
    required this.skills,
    required this.experience,
    required this.projects,
    required this.education,
    required this.certifications,
  });

  Future<void> generatePDF() async {


    final pdf = pw.Document();

    pw.Widget buildPdfSection(
        String title,
        String content,
        ) {

        return pw.Padding(

            padding: const pw.EdgeInsets.only(
            bottom: 20,
            ),

            child: pw.Column(

            crossAxisAlignment:
                pw.CrossAxisAlignment.start,

            children: [

                pw.Text(

                title,

                style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight:
                        pw.FontWeight.bold,
                ),
                ),

                pw.SizedBox(height: 8),

                pw.Text(content),

            ],
            ),
        );
        }

    pdf.addPage(

        pw.Page(

        pageFormat: PdfPageFormat.a4,

        build: (pw.Context context) {

            return pw.Padding(

            padding: const pw.EdgeInsets.all(20),

            child: pw.Column(

                crossAxisAlignment:
                    pw.CrossAxisAlignment.start,

                children: [

                pw.Center(

                    child: pw.Column(

                    children: [

                        pw.Text(

                        fullName,

                        style: pw.TextStyle(
                            fontSize: 28,
                            fontWeight:
                                pw.FontWeight.bold,
                        ),
                        ),

                        pw.SizedBox(height: 10),

                        pw.Text(
                        designation,
                        ),

                        pw.SizedBox(height: 10),

                        pw.Text(
                        "$phone | $email",
                        ),

                        pw.Text(
                        "$location | $linkedIn",
                        ),

                    ],
                    ),
                ),

                pw.SizedBox(height: 25),

                buildPdfSection(
                    "Professional Summary",
                    summary,
                ),

                buildPdfSection(
                    "Technical Skills",
                    skills,
                ),

                buildPdfSection(
                    "Work Experience",
                    experience,
                ),

                buildPdfSection(
                    "Projects",
                    projects,
                ),

                buildPdfSection(
                    "Education",
                    education,
                ),

                buildPdfSection(
                    "Certifications",
                    certifications,
                ),

                ],
            ),
            );
        },
        ),
    );

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool(
        "resumeUploaded",
        true,
    );

  await Printing.layoutPdf(

    onLayout: (PdfPageFormat format) async =>
        pdf.save(),
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Resume Preview",
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Container(

          padding: const EdgeInsets.all(25),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(16),

            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Center(
                child: Column(
                  children: [

                    Text(
                      fullName,

                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      designation,

                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "$phone | $email",
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "$location | $linkedIn",
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 30),

              buildSection(
                "Professional Summary",
                summary,
              ),

              buildSection(
                "Technical Skills",
                skills,
              ),

              buildSection(
                "Work Experience",
                experience,
              ),

              buildSection(
                "Projects",
                projects,
              ),

              buildSection(
                "Education",
                education,
              ),

              buildSection(
                "Certifications",
                certifications,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  onPressed: () {

                    generatePDF();

                  },

                  child: const Text(
                    "Download PDF",
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(
    String title,
    String content,
  ) {

    return Padding(

      padding: const EdgeInsets.only(
        bottom: 25,
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            title,

            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            content,

            style: const TextStyle(
              fontSize: 16,
            ),
          ),

        ],
      ),
    );
  }
}