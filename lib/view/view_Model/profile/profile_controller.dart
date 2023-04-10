import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmedia_firebase/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:socialmedia_firebase/res/components/textformfield.dart';
import 'package:socialmedia_firebase/utils/utils.dart';
import 'package:socialmedia_firebase/view/view_Model/services/session_manager.dart';

class ProfileController with ChangeNotifier {
  final nameUpdateController = TextEditingController();
  final phoneUpdateController = TextEditingController();

  final nameFocus = FocusNode();
  final phoneFocus = FocusNode();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final picker = ImagePicker();

  File? _image;
  File? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.camera,
                    color: AppColors.primaryIconColor,
                  ),
                  title: const Text("Camera"),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.image,
                    color: AppColors.primaryIconColor,
                  ),
                  title: const Text("Gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageref = firebase_storage
        .FirebaseStorage.instance
        .ref('/profile' + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask =
        storageref.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageref.getDownloadURL();
    ref
        .child(SessionController().userId.toString())
        .update({'image': newUrl.toString()}).then((value) {
      setLoading(false);
      Utils.toastMessage("Profile Updated");
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> showUserNameDialogAlert(BuildContext context, String name) {
    nameUpdateController.text = name;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Update Profile"),),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  MyInputTextField(
                    myTextEditingController: nameUpdateController,
                    focusNode: nameFocus,
                    onFieldSubmittedValue: (val) {},
                    onValidator: (val) {},
                    textHint: "Enter Name",
                    obscure: false,
                    keyBoardType: TextInputType.text,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    "Username": nameUpdateController.text.toString(),

                  }).then((value){
                    nameUpdateController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                ),
              )
            ],
          );
        });
  }



  Future<void> showPhoneDialogAlert(BuildContext context, String phonenumber) {
    phoneUpdateController.text = phonenumber;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text("Update Profile"),),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  MyInputTextField(
                    myTextEditingController: phoneUpdateController,
                    focusNode: phoneFocus,
                    onFieldSubmittedValue: (val) {},
                    onValidator: (val) {},
                    textHint: "Enter Phone Number",
                    obscure: false,
                    keyBoardType: TextInputType.number,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    "phone_no": phoneUpdateController.text.toString(),

                  }).then((value){
                    phoneUpdateController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                    "Ok",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                ),
              )
            ],
          );
        });
  }
}
