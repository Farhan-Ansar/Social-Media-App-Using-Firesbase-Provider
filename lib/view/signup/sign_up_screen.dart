import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia_firebase/utils/routes/route_name.dart';
import 'package:socialmedia_firebase/view/view_Model/signup/signup_controller.dart';
import '../../res/components/round_button.dart';
import '../../res/components/textformfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final userNode = FocusNode();
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
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ChangeNotifierProvider(
              create: (_) => SignUpController(),
              child: Consumer<SignUpController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
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
                          "Enter your email address\nto register your account",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * .03),
                              child: Column(
                                children: [
                                  MyInputTextField(
                                    myTextEditingController: usernameController,
                                    focusNode: userNode,
                                    enable: true,
                                    textHint: "user name",
                                    obscure: false,
                                    keyBoardType: TextInputType.text,
                                    onFieldSubmittedValue: (value) {
                                      //Onfield subbimetd
                                    },
                                    onValidator: (val) {
                                      return val.isEmpty
                                          ? "Enter User Name"
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  MyInputTextField(
                                    myTextEditingController: emailController,
                                    focusNode: emailNode,
                                    enable: true,
                                    textHint: "Email",
                                    obscure: false,
                                    keyBoardType: TextInputType.text,
                                    onFieldSubmittedValue: (value) {
                                      //Onfield subbimetd
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
                                      //Onfield subbimetd
                                    },
                                    onValidator: (val) {
                                      return val.isEmpty
                                          ? "Enter Password"
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height * .04,
                                  ),
                                  Round_Button(
                                    title: "Sign Up",
                                    loading: provider.loading,
                                    onpress: () {
                                      if (_formKey.currentState!.validate()) {
                                        provider.signup(
                                          context,
                                          usernameController.text,
                                          emailController.text.toString().trim(),
                                          passwordController.text,
                                        );

                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteName.loginView);
                                    },
                                    child: Text.rich(
                                      TextSpan(
                                          text: "Already Have an Account ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(fontSize: 15),
                                          children: [
                                            TextSpan(
                                              text: "Sign In",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2!
                                                  .copyWith(
                                                    fontSize: 15,
                                                    decoration: TextDecoration
                                                        .underline,
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
                  );
                },
              ),
            )),
      ),
    );
  }
}
