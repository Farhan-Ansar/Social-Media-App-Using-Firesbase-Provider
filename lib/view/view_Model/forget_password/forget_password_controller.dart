import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../utils/routes/route_name.dart';
import '../../../utils/utils.dart';
import '../services/session_manager.dart';

class ForgetController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;


  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgetPass(BuildContext context, String email1) async {
    setLoading(true);
    print(email1);
    try {
      await auth
          .sendPasswordResetEmail(email: email1.toString().trim())
          .then((value) {

        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginView);
        Utils.toastMessage("Please Check Your Email To Recover your Password");
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        setLoading(false);
      });
    } catch (error) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    }
  }
}
