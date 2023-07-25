import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:test/res/components/round_button.dart';
import 'package:test/utlis/routes/routes_name.dart';
import 'package:test/utlis/routes/utils.dart';
import 'package:provider/provider.dart';

import '../view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.black),
                    borderRadius: BorderRadius.circular(25)
              ),
              height: 400,
              width: 300,
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
              TextFormField(
                controller: _emailController,
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email",
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_sharp)),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      obscureText: _obsecurePassword.value,
                      focusNode: passwordFocusNode,
                     /* onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },*/
                      keyboardType: TextInputType.text,
                      obscuringCharacter: '^',
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          labelText: 'Password',
                          suffixIcon: InkWell(
                              onTap: () {
                                _obsecurePassword.value = !_obsecurePassword.value;
                              },
                              child: _obsecurePassword.value
                                  ? Icon(Icons.visibility_off_outlined)
                                  : Icon(Icons.visibility)),
                          prefixIcon: Icon(Icons.password)),
                    );
                  }),
              SizedBox(
                height: 11.h,
              ),
              RoundButton(
                  title: "Login",
                  onPress: () {
                    if (_emailController.text.isEmpty) {
                      Utils.flashErrorMessage("Enter Email", context);
                    } else if (_passwordController.text.isEmpty) {
                      Utils.flashErrorMessage("Enter password", context);
                    } else if (_passwordController.text.length < 6) {
                      Utils.flashErrorMessage("Enter 6 digit password", context);
                    } else {
                      Map data = {
                        'email': _emailController.text.toString(),
                        'password': _passwordController.text.toString(),
                      };
                      authViewModel.loginApi(data, context);
                      authViewModel.Login(_emailController.text.toString(), _passwordController.text.toString(),context);
                      print("API Hit");

                    }
                  }),
              SizedBox(height: height*.05,),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.signUp);
                  },
                  child: Text(("Don't have an Account? Sign Up?")))
        ],
      ),
            ),
          )),
    );
  }
}
