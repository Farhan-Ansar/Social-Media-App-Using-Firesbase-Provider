import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia_firebase/res/components/round_button.dart';
import 'package:socialmedia_firebase/res/components/textformfield.dart';
import 'package:socialmedia_firebase/utils/routes/route_name.dart';
import 'package:socialmedia_firebase/utils/utils.dart';
import 'package:socialmedia_firebase/view/view_Model/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .1,
                ),
                Text(
                  "Welcome To App",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter your email address \n to connect to your account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height * .03),
                      child: Column(
                        children: [
                          MyInputTextField(
                            myTextEditingController: emailController,
                            focusNode: emailNode,
                            enable: true,
                            textHint: "Email",
                            obscure: false,
                            keyBoardType: TextInputType.text,
                            onFieldSubmittedValue: (value) {
                             Utils.fieldFocus(context, emailNode, passwordNode);
                            },
                            onValidator: (val) {
                              return val.isEmpty ? "Enter Email" : null;
                            },
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          MyInputTextField(
                            myTextEditingController: passwordController,
                            focusNode: passwordNode,
                            enable: true,
                            textHint: "Password",
                            obscure: true,
                            keyBoardType: TextInputType.text,
                            onFieldSubmittedValue: (value) {
                              //Utils.fieldFocus(context, currentFocusNode, nextFocusNode)
                            },
                            onValidator: (val) {
                              return val.isEmpty ? "Enter Password" : null;
                            },
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RouteName.forgetPasswordView);
                             // print(passwordController);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Forget Password?",
                                style:
                                    Theme.of(context).textTheme.headline2!.copyWith(
                                          fontSize: 15,
                                          decoration: TextDecoration.underline,
                                        ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          ChangeNotifierProvider(
                              create:(_) => LoginController(),
                            child: Consumer<LoginController>(
                              builder: (context,provider,child){
                                return Round_Button(
                                  title: "Login",
                                  loading: false,
                                  onpress: () {
                                    if(_formKey.currentState!.validate()){
                                      provider.login(context, emailController.text.toString().trim(), passwordController.text.toString());
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * .01,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, RouteName.signUpView);
                            },
                            child: Text.rich(
                              TextSpan(
                                  text: "Don't have an Account?  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontSize: 15),
                                  children: [
                                    TextSpan(
                                      text: "Sign Up",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                            fontSize: 15,
                                            decoration: TextDecoration.underline,
                                          ),
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
