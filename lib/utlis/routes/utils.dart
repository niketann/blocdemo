import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        textColor: Colors.white,
        fontSize: 15,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.amberAccent);
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void flashErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        duration: Duration(seconds: 10),
        message: message,
        backgroundColor: Colors.black,
      )..show(context),
    );
  }

  static double averageRating(List<int>rating){
    var avgRating=0;
    for(int i=0;i<rating.length;i++){
      avgRating=avgRating+rating[i];
    }
    return double.parse((avgRating/rating.length).toStringAsFixed(1));
  }
}
