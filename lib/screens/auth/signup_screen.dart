import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final ApiService apiService = ApiService();

  bool isLoading = false;

  String selectedRole = "CANDIDATE";

  Future<void> registerUser() async {

    setState(() {
      isLoading = true;
    });

    try {

      Response response = await apiService.dio.post(
        "users/register",
        data: {
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "role": selectedRole,
        },
      );

      print(response.data);

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      List<String> usersList =

          prefs.getStringList(
            "usersList",
          ) ??

          [];

      String userData =

          "${response.data["id"]}|"

          "${nameController.text.trim()}|"

          "${emailController.text.trim()}|"

          "${selectedRole}";
          
      usersList.add(userData);

      await prefs.setStringList(
        "usersList",
        usersList,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful"),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      print("REGISTER ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Failed"),
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
        title: const Text("Signup"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: selectedRole,

                items: const [

                  DropdownMenuItem(
                    value: "CANDIDATE",
                    child: Text("Candidate"),
                  ),

                  DropdownMenuItem(
                    value: "EMPLOYER",
                    child: Text("Employer"),
                  ),

                ],

                onChanged: (value) {

                  setState(() {
                    selectedRole = value!;
                  });

                },

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Select Role",
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    registerUser();
                  },

                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Signup"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}