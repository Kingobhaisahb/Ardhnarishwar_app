import 'package:flutter/material.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployerPostJobsScreen
    extends StatefulWidget {

  const EmployerPostJobsScreen({
    super.key,
  });

  @override
  State<EmployerPostJobsScreen>
      createState() =>
          _EmployerPostJobsScreenState();
}

class _EmployerPostJobsScreenState
    extends State<EmployerPostJobsScreen> {

  final ApiService apiService =
      ApiService();

  final TextEditingController
      titleController =
          TextEditingController();

  final TextEditingController
      companyController =
          TextEditingController();

  final TextEditingController
      locationController =
          TextEditingController();

  final TextEditingController
      salaryController =
          TextEditingController();

  final TextEditingController
      descriptionController =
          TextEditingController();

  final TextEditingController
      skillsController =
          TextEditingController();

  bool isLoading = false;

  Future<void> postJob() async {

    if (
        titleController.text.isEmpty ||

        companyController.text.isEmpty ||

        locationController.text.isEmpty ||

        salaryController.text.isEmpty ||

        descriptionController.text.isEmpty ||

        skillsController.text.isEmpty
    ) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Fill all fields",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      List<String> skillsList =
          skillsController.text
              .split(",");

      Response response =
          await apiService.postJob(

        title:
            titleController.text.trim(),

        company:
            companyController.text.trim(),

        location:
            locationController.text.trim(),

        salary:
            salaryController.text.trim(),

        description:
            descriptionController.text.trim(),

        requiredSkills: skillsList,

        employerId: 1,
      );

      print(response.data);

      SharedPreferences prefs =

        await SharedPreferences
            .getInstance();

    int currentJobs =

        prefs.getInt(
        "activeJobsCount",
        ) ??

        0;

    await prefs.setInt(

    "activeJobsCount",

    currentJobs + 1,
    );

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Job Posted Successfully",
          ),
        ),
      );

      titleController.clear();

      companyController.clear();

      locationController.clear();

      salaryController.clear();

      descriptionController.clear();

      skillsController.clear();

    } catch (e) {

      print("POST JOB ERROR: $e");

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Failed To Post Job",
          ),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget customField({
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 15,
      ),

      child: TextField(

        controller: controller,

        maxLines: maxLines,

        decoration: InputDecoration(

          hintText: hint,

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding:
          const EdgeInsets.all(15),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          const Text(
            "Post Job",

            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          customField(
            hint: "Job Title",
            controller:
                titleController,
          ),

          customField(
            hint: "Company Name",
            controller:
                companyController,
          ),

          customField(
            hint: "Location",
            controller:
                locationController,
          ),

          customField(
            hint: "Salary",
            controller:
                salaryController,
          ),

          customField(
            hint:
                "Job Description",

            controller:
                descriptionController,

            maxLines: 4,
          ),

          customField(
            hint:
                "Required Skills (comma separated)",

            controller:
                skillsController,
          ),

          SizedBox(

            width: double.infinity,

            height: 55,

            child: ElevatedButton(

              onPressed:
                  isLoading
                      ? null
                      : postJob,

              child: isLoading

                  ? const CircularProgressIndicator()

                  : const Text(
                      "Post Job",
                    ),
            ),
          ),

        ],
      ),
    );
  }
}