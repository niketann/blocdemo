import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/res/components/round_button.dart';
import 'package:test/utlis/routes/routes_name.dart';
import 'package:test/utlis/routes/utils.dart';
import 'package:test/view_model/auth_view_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obsecurePassword1 = ValueNotifier<bool>(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmpasswordFocusNode = FocusNode();

  void createAccount() async{
    String email=_emailController.text.trim();
    String password=_passwordController.text.trim();
    String confirmpassword=_confirmpasswordController.text.trim();
    if(email=="" || password=="" || confirmpassword==""){
      log("please fill all details");
    }
    else if(password!=confirmpassword){
      log("password and confirm password does not match");
    }
    else{
      try{
        //craete account
        UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        log("user created");
        if(userCredential.user!=null){
          Navigator.pop(context);
        }
      }on FirebaseAuthException catch(ex){
        log(ex.code.toString());
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
            child: Container(
              width: 300,
              height: 400,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1,color: Colors.black),
                  borderRadius: BorderRadius.circular(25)
              ),
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
                  ValueListenableBuilder(
                      valueListenable: _obsecurePassword1,
                      builder: (context, value, child) {
                        return TextFormField(
                          obscureText: _obsecurePassword1.value,
                          focusNode: confirmpasswordFocusNode,
                          keyboardType: TextInputType.text,
                          obscuringCharacter: '^',
                          controller: _confirmpasswordController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              labelText: 'Password',
                              suffixIcon: InkWell(
                                  onTap: () {
                                    _obsecurePassword1.value = !_obsecurePassword1.value;
                                  },
                                  child: _obsecurePassword1.value
                                      ? Icon(Icons.visibility_off_outlined)
                                      : Icon(Icons.visibility)),
                              prefixIcon: Icon(Icons.password)),
                        );
                      }),
                  SizedBox(
                    height: height * .05,
                  ),
                  RoundButton(
                      title: "SignUp",
                      onPress: () {
                        if (_emailController.text.isEmpty) {
                          Utils.flashErrorMessage("Enter Email", context);
                        } else if (_passwordController.text.isEmpty) {
                          Utils.flashErrorMessage("Enter password", context);
                        } else if (_passwordController.text.length < 6) {
                          Utils.flashErrorMessage("Enter 6 digit password", context);
                        } else {
                          authViewModel.SignUp(_emailController.text.trim(),
                             _passwordController.text.trim(),
                             _confirmpasswordController.text.trim(),
                             context);
                          createAccount();
                          print("API Hit");
                        }
                      }),
                  SizedBox(height: height*.02,),
                  InkWell(
                    onTap:(){
                        Navigator.pushNamed(context, RoutesName.login);
                      },
                      child: Text(("Already have an Account? Login ")))
                ],
              ),
            ),
          )),
    );
  }
}
