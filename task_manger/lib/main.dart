import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manger/layout/home_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
          return MaterialApp(
            title: 'Flutter Demo',

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.light,
                        statusBarColor: Color.fromARGB(20, 0, 0, 0)),
                    backgroundColor: Color.fromARGB(21, 78, 73, 73),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    iconTheme: IconThemeData(color: Colors.black)),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: Colors.white),
                textTheme: const TextTheme(
                    bodyMedium: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light,
                      statusBarColor: Color.fromARGB(21, 78, 73, 73)),
                  backgroundColor: Color.fromARGB(21, 78, 73, 73),
                  elevation: 0.0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(color: Colors.white)),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Color.fromARGB(255, 153, 151, 151),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Colors.black,
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white70),
              textTheme: const TextTheme(
                  bodyMedium: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  bodySmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 89, 88, 88),
                  )),
            ),
            themeMode: ThemeMode.light,
            home: HomeLayout(),
          );
        }
      
}
