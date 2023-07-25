import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/res/components/round_button.dart';
import 'package:test/view_model/auth_view_model.dart';

class SafeHomeScreen extends StatefulWidget {
  const SafeHomeScreen({super.key});

  @override
  State<SafeHomeScreen> createState() => _SafeHomeScreenState();
}

class _SafeHomeScreenState extends State<SafeHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          RoundButton(
              title: "Log Out",
              onPress: () {
                authViewModel.Logout(context);
                print("Logout");
              }
          ),
        ],
        title: Text("Safe Home"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
