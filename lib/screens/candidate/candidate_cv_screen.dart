import 'package:flutter/material.dart';
import 'candidate_resume_preview_screen.dart';

class CandidateCVScreen extends StatefulWidget {
  const CandidateCVScreen({super.key});

  @override
  State<CandidateCVScreen> createState() =>
      _CandidateCVScreenState();
}

class _CandidateCVScreenState
    extends State<CandidateCVScreen> {

  final TextEditingController firstNameController =
      TextEditingController();

  final TextEditingController middleNameController =
      TextEditingController();

  final TextEditingController lastNameController =
      TextEditingController();

  final TextEditingController designationController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  final TextEditingController linkedInController =
      TextEditingController();

  final TextEditingController summaryController =
      TextEditingController();

  final TextEditingController skillsController =
      TextEditingController();

  final TextEditingController experienceController =
      TextEditingController();

  final TextEditingController projectsController =
      TextEditingController();

  final TextEditingController educationController =
      TextEditingController();

  final TextEditingController certificationController =
      TextEditingController();

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
              "CV Maker",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            buildTextField(
              "First Name",
              firstNameController,
            ),

            buildTextField(
              "Middle Name",
              middleNameController,
            ),

            buildTextField(
              "Last Name",
              lastNameController,
            ),

            buildTextField(
              "Designation",
              designationController,
            ),

            buildTextField(
              "Phone Number",
              phoneController,
            ),

            buildTextField(
              "Email",
              emailController,
            ),

            buildTextField(
              "Location",
              locationController,
            ),

            buildTextField(
              "LinkedIn URL",
              linkedInController,
            ),

            buildTextField(
              "Professional Summary",
              summaryController,
              maxLines: 5,
            ),

            buildTextField(
              "Technical Skills",
              skillsController,
              maxLines: 5,
            ),

            buildTextField(
              "Work Experience",
              experienceController,
              maxLines: 5,
            ),

            buildTextField(
              "Projects",
              projectsController,
              maxLines: 5,
            ),

            buildTextField(
              "Education",
              educationController,
              maxLines: 5,
            ),

            buildTextField(
              "Certifications & Learning",
              certificationController,
              maxLines: 5,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                    Navigator.push(

                        context,

                        MaterialPageRoute(

                        builder: (context) =>

                            CandidateResumePreviewScreen(

                            fullName:
                                "${firstNameController.text} ${middleNameController.text} ${lastNameController.text}",

                            designation:
                                designationController.text,

                            phone:
                                phoneController.text,

                            email:
                                emailController.text,

                            location:
                                locationController.text,

                            linkedIn:
                                linkedInController.text,

                            summary:
                                summaryController.text,

                            skills:
                                skillsController.text,

                            experience:
                                experienceController.text,

                            projects:
                                projectsController.text,

                            education:
                                educationController.text,

                            certifications:
                                certificationController.text,
                        ),
                        ),
                    );
                    },

                child: const Text(
                  "Generate Resume",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {

    return Padding(

      padding: const EdgeInsets.only(
        bottom: 20,
      ),

      child: TextField(

        controller: controller,
        maxLines: maxLines,

        decoration: InputDecoration(
          hintText: label,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}