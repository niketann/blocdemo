import 'dart:developer';
import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/model/User_model.dart';
import 'package:test/repository/auth_repository.dart';
import 'package:test/utlis/routes/routes_name.dart';
import 'package:test/utlis/routes/utils.dart';
import 'package:test/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading=false;
  bool get loading=>_loading;
  setLoading(bool value){
    _loading=value;
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    _myRepo.LoginApi(data).then((value) {
      setLoading(false);
      final userPreference =Provider.of<UserViewModel>(context,listen: false);
      Utils.flashErrorMessage("Login Succesfully", context);
      userPreference.saveUser(UserModel(
        token: value['token'].toString()
      ));
      Navigator.pushNamed(context, RoutesName.home);
      //log(value.toString());
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      //log(error.toString());
      if (kDebugMode) {
        Utils.flashErrorMessage(error.toString(), context);
        print(error.toString());
      }
    });
  }




  Future<void> Login(email,password,BuildContext context)async{
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      if(userCredential.user!=null){
        Utils.flashErrorMessage("Login Succesfully", context );
        Navigator.pushReplacementNamed(context, RoutesName.home);

      }
    }on FirebaseAuthException catch(ex){
      log(ex.code.toString());
    }
  }

  Future<void> SignUp(dynamic email,dynamic password,dynamic confirmpassword,BuildContext context)async{
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);
      if(userCredential.user!=null){
        Utils.flashErrorMessage("Login Succesfully", context );
        Navigator.pushReplacementNamed(context, RoutesName.home);

      }
    }on FirebaseAuthException catch(ex){
      log(ex.code.toString());
    }
  }
  Future<void> Logout(BuildContext context)async{
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, RoutesName.login);
  }
}
