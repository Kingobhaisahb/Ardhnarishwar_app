import 'package:flutter/material.dart';

import '../../services/api_service.dart';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CandidateProfileScreen
    extends StatefulWidget {

  const CandidateProfileScreen({
    super.key,
  });

  @override
  State<CandidateProfileScreen>
      createState() =>
          _CandidateProfileScreenState();
}

class _CandidateProfileScreenState
    extends State<CandidateProfileScreen> {

  final TextEditingController
      fullNameController =
          TextEditingController();

  final TextEditingController
      headlineController =
          TextEditingController();

  final TextEditingController
      locationController =
          TextEditingController();

  final TextEditingController
      phoneController =
          TextEditingController();

  final TextEditingController
      emailController =
          TextEditingController();

  final TextEditingController
      skillsController =
          TextEditingController();

  final TextEditingController
      educationController =
          TextEditingController();

  final TextEditingController
      experienceController =
          TextEditingController();

  final TextEditingController
      linkedInController =
          TextEditingController();

  final TextEditingController
      githubController =
          TextEditingController();

  final TextEditingController
      bioController =
          TextEditingController();

  final TextEditingController
      portfolioController =
          TextEditingController();

  bool profileUploaded = false;

  bool isEditing = false;

  final ApiService apiService =
      ApiService();

  Future<void> uploadProfile() async {

    try {

      Response response =

          await apiService.uploadProfile(

        fullName:
            fullNameController.text
                .trim(),

        email:
            emailController.text
                .trim(),

        headline:
            headlineController.text
                .trim(),

        location:
            locationController.text
                .trim(),

        phone:
            phoneController.text
                .trim(),

        linkedin:
            linkedInController.text
                .trim(),

        github:
            githubController.text
                .trim(),

        bio:
            bioController.text
                .trim(),

        skills:
            skillsController.text
                .trim(),

        education:
            educationController.text
                .trim(),

        experience:
            experienceController.text
                .trim(),

        portfolio:
            portfolioController.text
                .trim(),
      );

      print(response.data);

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      await prefs.setBool(
        "profileCompleted",
        true,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Profile Uploaded Successfully",
          ),
        ),
      );

      setState(() {

        profileUploaded = true;

        isEditing = false;
      });

    } catch (e) {

        print("PROFILE ERROR: $e");

        if (e is DioException) {

          print(
            "ERROR RESPONSE: ${e.response?.data}",
          );
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content: Text(
              "Profile Upload Failed",
            ),
          ),
        );
      }
    
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      padding:
          const EdgeInsets.all(20),

      child:
          profileUploaded &&
                  !isEditing

              ? buildProfilePreview()

              : buildProfileForm(),
    );
  }

  Widget buildProfileForm() {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        const Text(

          "My Profile",

          style: TextStyle(
            fontSize: 28,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 30),

        buildTextField(
          "Full Name",
          fullNameController,
        ),

        buildTextField(
          "Professional Headline",
          headlineController,
        ),

        buildTextField(
          "Location",
          locationController,
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
          "Skills",
          skillsController,
        ),

        buildTextField(
          "Education",
          educationController,
        ),

        buildTextField(
          "Experience",
          experienceController,
        ),

        buildTextField(
          "LinkedIn Link",
          linkedInController,
        ),

        buildTextField(
          "Github Link",
          githubController,
        ),

        buildTextField(
          "Portfolio",
          portfolioController,
        ),

        buildTextField(
          "Bio",
          bioController,

          maxLines: 5,
        ),

        const SizedBox(height: 30),

        SizedBox(

          width: double.infinity,

          child: ElevatedButton(

            onPressed: () {

              uploadProfile();
            },

            child: const Text(
              "Update Profile",
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfilePreview() {

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Text(

          fullNameController.text,

          style: const TextStyle(
            fontSize: 28,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(

          headlineController.text,

          style: const TextStyle(
            color: Colors.blue,

            fontSize: 18,

            fontWeight:
                FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          locationController.text,
        ),

        const SizedBox(height: 30),

        profileInfoCard(
          "Skills",
          skillsController.text,
        ),

        profileInfoCard(
          "Education",
          educationController.text,
        ),

        profileInfoCard(
          "Experience",
          experienceController.text,
        ),

        profileInfoCard(
          "Bio",
          bioController.text,
        ),

        const SizedBox(height: 30),

        SizedBox(

          width: double.infinity,

          child: ElevatedButton(

            onPressed: () {

              setState(() {

                isEditing = true;
              });
            },

            child: const Text(
              "Edit Profile",
            ),
          ),
        ),
      ],
    );
  }

  Widget profileInfoCard(

    String title,

    String value,

  ) {

    return Container(

      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          15,
        ),

        boxShadow: [

          BoxShadow(
            color:
                Colors.grey.shade300,

            blurRadius: 5,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(

            title,

            style: const TextStyle(

              color: Colors.blue,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(value),
        ],
      ),
    );
  }

  Widget buildTextField(

    String label,

    TextEditingController controller, {

    int maxLines = 1,

  }) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 20,
      ),

      child: TextField(

        controller: controller,

        maxLines: maxLines,

        decoration: InputDecoration(

          labelText: label,

          border: OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              12,
            ),
          ),
        ),
      ),
    );
  }
}