import 'package:flutter/material.dart';
import 'package:socialmedia_firebase/res/color.dart';

class MyInputTextField extends StatelessWidget {
  final TextEditingController myTextEditingController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;
  final String textHint;
  final bool obscure, enable, autofocus;
  final TextInputType keyBoardType;

  //constructor
  const MyInputTextField({
    Key? key,
    required this.myTextEditingController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.onValidator,
    required this.textHint,
    required this.obscure,
    this.enable = true,
    this.autofocus = false,
    required this.keyBoardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: myTextEditingController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        obscureText: obscure,
        enabled: enable,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(height:0, fontSize: 19),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          hintText: textHint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(height:0,color: AppColors.primaryTextTextColor!.withOpacity(0.8)),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textFieldDefaultFocus,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),

          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          //error border color
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.alertColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),

          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.textFieldDefaultBorderColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),

        ),
      ),
    );
  }
}
