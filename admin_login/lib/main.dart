
//import 'package:admin_login/experiment/add_experimet.dart';
import 'package:admin_login/chemical/add_chemical.dart';
import 'package:admin_login/experiment/add_experimet.dart';
import 'package:admin_login/experiment/experiment_database.dart';
import 'package:admin_login/firebase_options.dart';
import 'package:admin_login/login/login.dart';
import 'package:admin_login/user/user_database.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:get/get.dart';
//import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Ensure this is imported
  );
  //WidgetsFlutterBinding.ensureInitialized();
  //var firebaseApp = await Firebase.initializeApp();

  // try {
  //   // Initialize Firebase and register controllers lazily
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   ).then((value) {
  //     Get.put(AuthenticationRepository());
  //     // Use lazyPut for the SignupPageController
  //     Get.lazyPut<SignupPageController>(() => AdminLoginPage());
  //   });
  // } catch (e) {
  //   print('Error initializing Firebase: $e');
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserListScreen(),
    );
  }
}

