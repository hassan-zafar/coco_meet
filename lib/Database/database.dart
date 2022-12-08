import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coco_meet/Constants/collections.dart';
import 'package:coco_meet/Models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/custom_toast.dart';

class DatabaseMethods {
  // Future<Stream<QuerySnapshot>> getproductData() async {
  //   return FirebaseFirestore.instance.collection(productCollection).snapshots();
  // }

  Future fetchCalenderDataFromFirebase() async {
    final QuerySnapshot calenderMeetings = await calenderRef.get();

    return calenderMeetings;
  }

  Future<bool> loginAnonymosly() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      UserCredential auth = await _auth.signInAnonymously();
      String date = DateTime.now().toString();

      DateTime dateparse = DateTime.parse(date);
      String formattedDate =
          '${dateparse.day}-${dateparse.month}-${dateparse.year}';
      final AppUserModel appUser = AppUserModel(
        id: auth.user!.uid,
        name: 'Guest User',
        email: 'guest@guest.com',
        androidNotificationToken: '',
        imageUrl: '',
        password: '',
        subscriptionEndTIme: DateTime.now().toIso8601String(),
        phoneNo: '',
        isAdmin: false,
      );
      final bool _isOkay = await DatabaseMethods().addUser(appUser);
      if (_isOkay) {
        currentUser = appUser;

        // UserLocalData().storeAppUserData(appUser: appUser);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      CustomToast.errorToast(message: error.toString());
    }
    return false;
  }

  Future<bool> addUser(AppUserModel appUser) async {
    await userRef.doc(appUser.id).set(appUser.toMap()).catchError((Object e) {
      CustomToast.successToast(message: e.toString());
      // ignore: invalid_return_type_for_catch_error
      return false;
    });
    return true;
  }

  Future<AppUserModel> fetchUserInfoFromFirebase({
    required String uid,
  }) async {
    final DocumentSnapshot _user = await userRef.doc(uid).get();
    currentUser = AppUserModel.fromDocument(_user);
    createToken(uid);
    isAdmin = currentUser!.isAdmin;
    print(currentUser!.email);
    return currentUser!;
  }

  createToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      userRef.doc(uid).update({
        "androidNotificationToken": token,
      });
    });
  }



  addUserInfoToFirebase({
    required final String password,
    required final String? name,
    required final String? joinedAt,
    required final int? phoneNo,
    required final String? imageUrl,
    required final Timestamp? createdAt,
    required final String email,
    required final String userId,
    final bool? isAdmin,
  }) {
    print("addUserInfoToFirebase");
    return userRef.doc(userId).set({
      'id': userId,
      'name': name,
      'phoneNo': phoneNo,
      'password': password,
      'createdAt': createdAt,
      'isAdmin': isAdmin,
      'email': email,
      'joinedAt': joinedAt,
      'imageUrl': imageUrl,
      'androidNotificationToken': "",
    }).then((value) {
      // currentUser = userModel;
    }).catchError(
      (Object obj) {
        CustomToast.errorToast(message: obj.toString());
      },
    );
  }
}
