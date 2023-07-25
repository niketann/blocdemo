import 'package:flutter/material.dart';
import 'package:test/res/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 30,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.buttonColor),
        child: Center(
          child: loading
              ? CircleAvatar()
              : Text(
                  title,
                  style: TextStyle(fontSize: 15, color: AppColors.whiteColor),
                ),
        ),
      ),
    );
  }
}
