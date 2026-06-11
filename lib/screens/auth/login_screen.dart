import '../../services/api_service.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'signup_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../candidate/candidate_home_screen.dart';

import '../employer/employer_home_screen.dart';

import '../admin/admin_home_screen.dart';

class LoginScreen
    extends StatefulWidget {

  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen>
      createState() =>
          _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  final ApiService apiService =
      ApiService();

  bool isLoading = false;

  Future<void> loginUser() async {

    setState(() {
      isLoading = true;
    });

    try {

      Response response =
          await apiService.loginUser(

        email:
            emailController.text.trim(),

        password:
            passwordController.text.trim(),
      );

      print("LOGIN RESPONSE = ${response.data}");

      SharedPreferences prefs =

          await SharedPreferences
              .getInstance();

      await prefs.setString(

        "role",

        response.data["role"],
      );

      await prefs.setInt(

        "userId",

        response.data["id"],
      );

      String role =
          response.data["role"];

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Login Successful",
          ),
        ),
      );

      if (role == "CANDIDATE") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context) =>

                const CandidateHomeScreen(),
          ),
        );
      }

      else if (role == "EMPLOYER") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context) =>

                const EmployerHomeScreen(),
          ),
        );
      }

      else if (role == "ADMIN") {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context) =>

                const AdminHomeScreen(),
          ),
        );
      }

    } catch (e) {

      print("ERROR IS: $e");

      if (e is DioException) {

        print(
          "ERROR RESPONSE: ${e.response?.data}",
        );
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "Login Failed",
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Ardhnarishwar",
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding:
              const EdgeInsets.all(
            20,
          ),

          child: Column(

            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              const SizedBox(
                  height: 50),

              const CircleAvatar(

                radius: 60,

                backgroundImage:
                    AssetImage(
                  "assets/images/logo.png",
                ),
              ),

              const SizedBox(
                  height: 20),

              const Text(

                "Ardhnarishwar",

                style: TextStyle(

                  fontSize: 34,

                  fontWeight:
                      FontWeight.bold,

                  color:
                      Color(0xFF6C3BFF),
                ),
              ),

              const SizedBox(
                  height: 10),

              const Text(

                "Talent Meets Opportunity",

                style: TextStyle(

                  color:
                      Colors.white70,

                  fontSize: 16,
                ),
              ),

              const SizedBox(
                  height: 40),

              TextField(

                controller:
                    emailController,

                decoration:
                    const InputDecoration(

                  labelText: "Email",

                  prefixIcon:
                      Icon(Icons.email),

                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                  height: 20),

              TextField(

                controller:
                    passwordController,

                obscureText: true,

                decoration:
                    const InputDecoration(

                  labelText:
                      "Password",

                  prefixIcon:
                      Icon(Icons.lock),

                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                  height: 30),

              SizedBox(

                width:
                    double.infinity,

                child:
                    ElevatedButton(

                  onPressed: () {

                    loginUser();
                  },

                  child: isLoading

                      ? const CircularProgressIndicator(
                          color:
                              Colors.white,
                        )

                      : const Text(
                          "Login",
                        ),
                ),
              ),

              const SizedBox(
                  height: 15),

              TextButton(

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>

                          const SignupScreen(),
                    ),
                  );
                },

                child: const Text(

                  "Don't have an account? Signup",

                  style: TextStyle(
                    color:
                        Color(0xFF4FD1C5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}