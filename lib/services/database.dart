import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //collection reference

  final CollectionReference userProfile =
      Firestore.instance.collection('profile');

  // Future updateUserProfile(String username, String bio, )
}
