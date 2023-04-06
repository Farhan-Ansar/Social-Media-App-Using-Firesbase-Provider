import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/components/round_button.dart';
import '../../res/components/textformfield.dart';
import '../../utils/routes/route_name.dart';
import '../../utils/utils.dart';
import '../view_Model/forget_password/forget_password_controller.dart';
import '../view_Model/login/login_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final emailNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    emailNode.dispose();
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
                  "Forget Password",
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter your email address \n to Recovered your Password",
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
                          onFieldSubmittedValue: (value) {},
                          onValidator: (val) {
                            return val.isEmpty ? "Enter Email" : null;
                          },
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        ChangeNotifierProvider(
                          create: (_) => ForgetController(),
                          child: Consumer<ForgetController>(
                            builder: (context, provider, child) {
                              return Round_Button(
                                title: "Recovered Password",
                                loading: false,
                                onpress: () {
                                  if (_formKey.currentState!.validate()) {
                                    print(emailController.text);
                                    provider.forgetPass(context, emailController.text);
                                    // provider.login(context, emailController.text.toString(), passwordController.text.toString());
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
