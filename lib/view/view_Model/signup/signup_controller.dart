import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia_firebase/utils/utils.dart';

import '../../../utils/routes/route_name.dart';

class SignUpController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signup(BuildContext context,String username, String email, String password) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value){
            
            ref.child(value.user!.uid.toString()).set({
              "uid" : value.user!.uid.toString(),
              "email":email,
              "password": password,
              "online_Status":"none",
              "phone_no":"",
              "image":"",
              "Username": username,

            }).then((value){
              setLoading(false);
              Navigator.pushNamed(context, RouteName.loginView);

            }).onError((error, stackTrace){
              setLoading(false);
              Utils.toastMessage(error.toString());
            });
            
            Utils.toastMessage("User Created Successfully");
            setLoading(false);
          }).onError((error, stackTrace){
            Utils.toastMessage(error.toString());
            setLoading(false);
          });
    } catch (error) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    }
  }
}
