
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:socialmedia_firebase/utils/routes/route_name.dart';
import 'package:socialmedia_firebase/view/view_Model/services/session_manager.dart';

class SplashServices{


  void isLogin(BuildContext context){
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null)
    {
      SessionController().userId = user.uid.toString();
      Timer( const Duration(seconds : 3),()=> Navigator.pushNamed(context, RouteName.dashboardView));
    }
    else
    {
      Timer( const Duration(seconds : 3),()=> Navigator.pushNamed(context, RouteName.loginView));
    }

  }

}