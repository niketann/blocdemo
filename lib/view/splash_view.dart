import 'package:flutter/material.dart';
import 'package:test/view_model/services/splashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices=SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.checkAuthendication(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Center(child: Text("splash screen",))
        ],
      ),
    );
  }
}
