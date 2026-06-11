import 'package:flutter/material.dart';

import 'screens/auth/login_screen.dart';

void main() {

  runApp(
    const MyApp(),
  );
}

class MyApp
    extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner:
          false,

      title: 'Ardhnarishwar',

      theme: ThemeData(

        brightness:
            Brightness.dark,

        scaffoldBackgroundColor:
            const Color(
          0xFF0F0B1E,
        ),

        primaryColor:
            const Color(
          0xFF6C3BFF,
        ),

        colorScheme:
            const ColorScheme.dark(

          primary:
              Color(
            0xFF6C3BFF,
          ),

          secondary:
              Color(
            0xFF4FD1C5,
          ),
        ),

        fontFamily:
            "Roboto",

        appBarTheme:
            const AppBarTheme(

          backgroundColor:
              Color(
            0xFF1A1333,
          ),

          elevation: 0,

          centerTitle: true,

          titleTextStyle:
              TextStyle(

            color: Colors.white,

            fontSize: 24,

            fontWeight:
                FontWeight.bold,
          ),
        ),

        drawerTheme:
            const DrawerThemeData(

          backgroundColor:
              Color(
            0xFF161026,
          ),
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(

          style:
              ElevatedButton.styleFrom(

            backgroundColor:
                const Color(
              0xFF6C3BFF,
            ),

            foregroundColor:
                Colors.white,

            elevation: 10,

            shadowColor:
                Colors.deepPurple,

            padding:
                const EdgeInsets.symmetric(
              vertical: 18,
            ),

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),

            textStyle:
                const TextStyle(

              fontSize: 18,

              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),

        inputDecorationTheme:
            InputDecorationTheme(

          filled: true,

          fillColor:
              const Color(
            0xFF1A1333,
          ),

          hintStyle:
              const TextStyle(
            color:
                Colors.white54,
          ),

          labelStyle:
              const TextStyle(
            color:
                Colors.white70,
          ),

          border:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            borderSide:
                BorderSide.none,
          ),

          enabledBorder:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            borderSide:
                BorderSide.none,
          ),

          focusedBorder:
              OutlineInputBorder(

            borderRadius:
                BorderRadius.circular(
              18,
            ),

            borderSide:
                const BorderSide(

              color:
                  Color(
                0xFF6C3BFF,
              ),

              width: 2,
            ),
          ),
        ),
      ),

      home:
          const LoginScreen(),
    );
  }
}