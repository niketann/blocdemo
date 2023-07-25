import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:test/firebase_options.dart';
import 'package:test/utlis/routes/routes.dart';
import 'package:test/utlis/routes/routes_name.dart';
import 'package:test/view_model/auth_view_model.dart';
import 'package:test/view_model/user_view_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  QuerySnapshot snapshot= await FirebaseFirestore.instance.collection("user").get();

  print(snapshot.docs.toString());

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
    builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: (FirebaseAuth.instance.currentUser!=null)?RoutesName.home:RoutesName.login,
          onGenerateRoute: Routes.generateRoute,
        ),
      );
      }
    );
  }
}
