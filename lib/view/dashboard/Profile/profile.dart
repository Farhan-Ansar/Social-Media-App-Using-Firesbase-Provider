import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia_firebase/res/color.dart';
import 'package:socialmedia_firebase/res/components/round_button.dart';
import 'package:socialmedia_firebase/view/view_Model/profile/profile_controller.dart';
import 'package:socialmedia_firebase/view/view_Model/services/session_manager.dart';
import 'dart:io';

import '../../../utils/routes/route_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref("users");
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (BuildContext context, provider, Widget? child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: StreamBuilder(
                stream:
                    ref.child(SessionController().userId.toString()).onValue,
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryIconColor,
                    ));
                  } else if (snapshot.hasData) {
                    Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                    return Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: Center(
                                child: Container(
                                  height: 130,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(70),
                                    border: Border.all(
                                      color: AppColors.primaryIconColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: provider.image == null
                                        ? map["image"].toString() == ""
                                            ? const Icon(
                                                Icons.person,
                                                size: 35,
                                              )
                                            : Image(
                                                image: NetworkImage(
                                                    map["image"].toString()),
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    color: Colors.black87,
                                                  ));
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    child: const Icon(
                                                      Icons.error,
                                                      color:
                                                          AppColors.alertColor,
                                                    ),
                                                  );
                                                },
                                              )
                                        : Image.file(
                                            File(provider.image!.path).absolute,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                provider.pickImage(context);
                              },
                              child: const CircleAvatar(
                                radius: 14,
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(
                                  Icons.add,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ReuseableRow(
                          title: "Username",
                          iconData: Icons.person,
                          value: map["Username"],
                        ),
                        ReuseableRow(
                          title: "Phone",
                          iconData: Icons.phone,
                          value: map["phone_no"] == ""
                              ? "xxxx-xx-xx-xxx"
                              : map["phone_no"],
                        ),
                        ReuseableRow(
                          title: "Email",
                          iconData: Icons.email,
                          value: map["email"],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Round_Button(
                            title: "Logout",
                            onpress: () {
                              auth.signOut();
                              Navigator.pushNamed(context, RouteName.loginView);
                            })
                      ],
                    );
                  } else {
                    return Center(
                        child: Text(
                      "Some Thing Wrong",
                      style: Theme.of(context).textTheme.subtitle1,
                    ));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final title, value;
  final IconData iconData;
  ReuseableRow(
      {Key? key,
      required this.title,
      required this.value,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          trailing: Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const Divider(
          color: AppColors.dividedColor,
        )
      ],
    );
  }
}
