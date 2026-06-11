import 'package:dio/dio.dart';

import '../utils/constants.dart';

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  final Dio dio = Dio(

    BaseOptions(

      baseUrl: baseUrl,

      connectTimeout:
          const Duration(seconds: 30),

      receiveTimeout:
          const Duration(seconds: 30),

      sendTimeout:
          const Duration(seconds: 30),

      headers: {

        "Content-Type":
            "application/json",
      },
    ),
  );

  Future<Response> loginUser({

    required String email,

    required String password,

  }) async {

    try {

      print("BASE URL = ${dio.options.baseUrl}");
      print("EMAIL = $email");

      Response response =

          await dio.post(

         "users/login",

        data: {

          "email": email,

          "password": password,
        },
      );

      return response;

    } catch (e, stackTrace) {

      print("LOGIN ERROR = $e");
      print("STACKTRACE = $stackTrace");

      rethrow;
    }
  }

  Future<Response> getJobs() async {

    try {

      Response response =
          await dio.get(
        "jobs",
      );

      return response;

    } catch (e) {

      rethrow;
    }
  }

  Future<Response> getEmployerJobs({

    required int employerId,

  }) async {

    try {

      Response response =

          await dio.get(
        "jobs/employer/$employerId",
      );

      return response;

    } catch (e) {

      rethrow;
    }
  }

  Future<Response> postJob({

    required String title,

    required String company,

    required String location,

    required String salary,

    required String description,

    required List<String> requiredSkills,

    required int employerId,

  }) async {

    try {

      Response response =

          await dio.post(

        "jobs",

        data: {

          "title": title,

          "company": company,

          "location": location,

          "salary": salary,

          "description":
              description,

          "requiredSkills":
              requiredSkills,

          "employer": {

            "id": employerId,
          },
        },
      );

      return response;

    } catch (e) {

      rethrow;
    }
  }

  Future<Response> deleteJob({

    required int jobId,

  }) async {

    try {

      Response response =

          await dio.delete(
        "jobs/$jobId",
      );

      return response;

    } catch (e) {

      rethrow;
    }
  }

  Future<Response> applyJob({

    required int candidateId,

    required int jobId,

  }) async {

    try {

      Response response =

          await dio.post(

        "applications",

        data: {

          "candidate": {

            "id": candidateId,
          },

          "job": {

            "id": jobId,
          },
        },
      );

      return response;

    } catch (e) {

      rethrow;
    }
  }

  Future<Response> scanATSResume({
    required File resumeFile,
  }) async {

    try {

      String fileName =

          resumeFile.path
              .split('/')
              .last;

      FormData formData =

          FormData.fromMap({

        "file":

            await MultipartFile.fromFile(

          resumeFile.path,

          filename: fileName,
        ),
      });

      Response response =

          await dio.post(

        "ats/scan",

        data: formData,
      );

      return response;

    } catch (e) {

      rethrow;
    }
  }

  Future<Response> uploadProfile({

  required String fullName,
  required String email,
  required String headline,
  required String location,
  required String phone,
  required String linkedin,
  required String github,
  required String portfolio,
  required String bio,
  required String skills,
  required String education,
  required String experience,

  }) async {

    try {

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      int userId =
          prefs.getInt("userId") ?? 0;

      FormData formData =
          FormData.fromMap({

        "fullName": fullName,

        "email": email,

        "headline": headline,

        "location": location,

        "phone": phone,

        "linkedin": linkedin,

        "github": github,

        "portfolio": portfolio,

        "bio": bio,

        "skills": skills,

        "education": education,

        "experience": experience,

        "userId": userId,
      });

      Response response =

          await dio.post(

        "profile/upload",

        data: formData,

        options: Options(

          headers: {

            "Content-Type":
                "multipart/form-data",
          },
        ),
      );

      return response;

    } catch (e) {

      rethrow;
    }
  }
}