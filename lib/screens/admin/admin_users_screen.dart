import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdminUsersScreen
    extends StatefulWidget {

  const AdminUsersScreen({
    super.key,
  });

  @override
  State<AdminUsersScreen>
      createState() =>
          _AdminUsersScreenState();
}

class _AdminUsersScreenState
    extends State<AdminUsersScreen> {

  List<Map<String, String>>
      users = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadUsers();
  }

  Future<void> loadUsers() async {

    SharedPreferences prefs =

        await SharedPreferences
            .getInstance();

    List<String> usersList =

        prefs.getStringList(
              "usersList",
            ) ??

            [];

    List<Map<String, String>>
        loadedUsers = [];

    for (String user
        in usersList) {

      List<String> parts =
          user.split("|");

      loadedUsers.add({

            "id":
                parts[0],

            "name":
                parts[1],

            "email":
                parts[2],

            "role":
                parts[3],
            });
    }

    setState(() {

      users = loadedUsers;

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

          : users.isEmpty

              ? const Center(
                  child: Text(
                    "No Users Found",
                  ),
                )

              : ListView.builder(

                  itemCount:
                      users.length,

                  itemBuilder:
                      (context, index) {

                    final user =
                        users[index];

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

                            user["name"] ??
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
                            "Email: ${user["email"]}",
                          ),

                          const SizedBox(
                              height: 5),

                          Text(
                            "Role: ${user["role"]}",
                          ),
                          const SizedBox(height: 5),

                            Text(
                                "ID: ${user["id"]}",
                            ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}