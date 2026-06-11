import 'package:flutter/material.dart';

class CandidateAIChatScreen
    extends StatefulWidget {

  const CandidateAIChatScreen({
    super.key,
  });

  @override
  State<CandidateAIChatScreen>
      createState() =>
          _CandidateAIChatScreenState();
}

class _CandidateAIChatScreenState
    extends State<CandidateAIChatScreen> {

  final TextEditingController
      messageController =
          TextEditingController();

  List<Map<String, dynamic>>
      messages = [

    {
      "text":
          "Hi! I'm Aria, your Job Assistant 👋",
      "isUser": false,
    },

    {
      "text":
          "How can I help you today?",
      "isUser": false,
    },
  ];

  void sendMessage(
      String userMessage) {

    if (userMessage
        .trim()
        .isEmpty) {
      return;
    }

    setState(() {

      messages.add({

        "text": userMessage,

        "isUser": true,
      });
    });

    String botReply =
        generateReply(
      userMessage,
    );

    Future.delayed(

      const Duration(
        milliseconds: 500,
      ),

      () {

        setState(() {

          messages.add({

            "text": botReply,

            "isUser": false,
          });
        });
      },
    );

    messageController.clear();
  }

  String generateReply(
      String message) {

    String msg =
        message.toLowerCase();

    if (msg.contains("apply")) {

      return "Go to the Jobs section and click Apply Now on any job.";
    }

    else if (msg.contains(
        "resume")) {

      return "Keep your resume clear, short, and ATS friendly with relevant keywords.";
    }

    else if (msg.contains(
        "recruiter")) {

      return "You can contact recruiters professionally through LinkedIn or company portals.";
    }

    else if (msg.contains(
        "ats")) {

      return "ATS systems scan resumes for keywords and relevant skills.";
    }

    else if (msg.contains(
        "interview")) {

      return "Practice DSA, communication, and project explanations before interviews.";
    }

    return "I'm still learning 🤖";
  }

  Widget quickButton(
      String text) {

    return Padding(

      padding:
          const EdgeInsets.only(
        right: 10,
      ),

      child: ActionChip(

        label: Text(text),

        onPressed: () {

          sendMessage(text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Aria AI Assistant",
        ),
      ),

      body: Column(

        children: [

          const SizedBox(height: 10),

          SizedBox(

            height: 50,

            child: ListView(

              scrollDirection:
                  Axis.horizontal,

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 10,
              ),

              children: [

                quickButton(
                  "How to apply for a job?",
                ),

                quickButton(
                  "Resume tips",
                ),

                quickButton(
                  "ATS help",
                ),

                quickButton(
                  "Interview tips",
                ),
              ],
            ),
          ),

          Expanded(

            child: ListView.builder(

              padding:
                  const EdgeInsets.all(
                15,
              ),

              itemCount:
                  messages.length,

              itemBuilder:
                  (context, index) {

                final message =
                    messages[index];

                bool isUser =
                    message["isUser"];

                return Align(

                  alignment: isUser

                      ? Alignment
                          .centerRight

                      : Alignment
                          .centerLeft,

                  child: Container(

                    margin:
                        const EdgeInsets.only(
                      bottom: 12,
                    ),

                    padding:
                        const EdgeInsets.all(
                      14,
                    ),

                    decoration:
                        BoxDecoration(

                      color: isUser

                          ? Colors.blue

                          : Colors.grey
                              .shade200,

                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                    ),

                    child: Text(

                      message["text"],

                      style: TextStyle(

                        color: isUser

                            ? Colors.white

                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(

            padding:
                const EdgeInsets.all(
              12,
            ),

            child: Row(

              children: [

                Expanded(

                  child: TextField(

                    controller:
                        messageController,

                    decoration:
                        InputDecoration(

                      hintText:
                          "Ask me anything...",

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    width: 10),

                FloatingActionButton(

                  mini: true,

                  onPressed: () {

                    sendMessage(
                      messageController.text,
                    );
                  },

                  child:
                      const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}