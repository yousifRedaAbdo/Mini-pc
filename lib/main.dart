import 'package:flutter/material.dart';
import 'package:mini_pc/screens/homeScreen/view/home_screen.dart';
import 'package:mini_pc/services/dio.dart';
import 'package:mini_pc/services/provider.dart';
import 'package:provider/provider.dart';

void main() {
  dioHelper.int();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff437EEB)),
          useMaterial3: true,
        ),
        home: HomeScreen(),
      ),
    );
  }
}

