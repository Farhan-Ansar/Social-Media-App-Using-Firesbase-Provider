import 'package:flutter/material.dart';
import 'package:socialmedia_firebase/res/color.dart';

class Round_Button extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  final Color color, textcolor;
  final bool loading;

  Round_Button({
    Key? key,
    required this.title,
    required this.onpress,
    this.loading = false,
    this.color = AppColors.primaryButtonColor,
    this.textcolor = AppColors.whiteColor,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: loading ? null : onpress,
        child: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(50)),
          child: loading ? const  Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(child: Text(title,style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 14,color: textcolor),)),
        ),
      ),
    );
  }
}
