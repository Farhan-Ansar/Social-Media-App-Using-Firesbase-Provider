import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_firebase/res/color.dart';
import 'package:socialmedia_firebase/view/view_Model/services/session_manager.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User List"),
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
          query: ref,
          itemBuilder: (context, snapshot, animation, index) {
            if(SessionController().userId.toString() == snapshot.child("uid").value.toString())
            {
              return Container();
            }
            else{
              return Card(
                child: ListTile(
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryButtonColor)),
                    child: snapshot.child("image").value.toString() == ""
                        ? const Icon(Icons.person)
                        : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                snapshot.child("image").value.toString()))),
                  ),
                  title: Text(snapshot.child("Username").value.toString()),
                  subtitle: Text(snapshot.child("email").value.toString()),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
