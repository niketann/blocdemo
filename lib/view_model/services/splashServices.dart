import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:test/model/User_model.dart';
import 'package:test/utlis/routes/routes_name.dart';
import 'package:test/view_model/user_view_model.dart';

class SplashServices{
  Future<UserModel> getUserData() =>UserViewModel().getUser();
  void checkAuthendication(BuildContext context)async{
    getUserData().then((value){

      if(value.token=="null"|| value.token=='') {
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error,stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });
  }



}