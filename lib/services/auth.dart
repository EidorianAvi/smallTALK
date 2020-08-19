import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService databaseService = DatabaseService();
  QuerySnapshot userInfo;


  //create user object based on FirebaseUser
  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => userFromFirebaseUser(user));
  }


  //sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

//      HelperFunctions.saveUserLoggedInSharedPreference(true);
//      HelperFunctions.saveUserEmailSharedPreference(email);

      databaseService.getUserByEmail(email)
        .then((val) {
          userInfo = val;
//          HelperFunctions.saveUsernameSharedPreference(userInfo.documents[0].data['username']);
//          HelperFunctions.saveUserImageSharedPreference(userInfo.documents[0].data['image']);
//          HelperFunctions.saveUserFavoritesSharedPreference(userInfo.documents[0].data['favorites']);
//          HelperFunctions.saveUserUidSharedPreference(userInfo.documents[0].data['id']);
      });

      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserProfile(
          email, "Temp Username", "Short bio here", "assets/avatar.png", user.uid.toString(), []);

//      HelperFunctions.saveUserLoggedInSharedPreference(true);
//      HelperFunctions.saveUserEmailSharedPreference(email);

      databaseService.getUserByEmail(email)
          .then((val) {
        userInfo = val;
//        HelperFunctions.saveUsernameSharedPreference(userInfo.documents[0].data['username']);
//        HelperFunctions.saveUserImageSharedPreference(userInfo.documents[0].data['image']);
//        HelperFunctions.saveUserFavoritesSharedPreference(userInfo.documents[0].data['favorites']);
//        HelperFunctions.saveUserUidSharedPreference(userInfo.documents[0].data['id']);
      });

      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // reset password link
  Future resetPass(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
//      HelperFunctions.saveUserUidSharedPreference('');
//      HelperFunctions.saveUsernameSharedPreference('');
//      HelperFunctions.saveUserImageSharedPreference('');
//      HelperFunctions.saveUserFavoritesSharedPreference([]);
//      HelperFunctions.saveUserLoggedInSharedPreference(false);
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

// FirebaseUser user = FirebaseAuth.getInstance().getCurrentUser();
