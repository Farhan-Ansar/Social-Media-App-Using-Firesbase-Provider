import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocus(BuildContext context, FocusNode currentFocusNode,
      FocusNode nextFocusNode) {
    currentFocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  static toastMessage(String messageToast) {
    Fluttertoast.showToast(
      msg: messageToast,
      backgroundColor: Colors.teal,
      fontSize: 15,
      textColor: Colors.white,
    );
  }
}
