import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:small_talk/models/user_profile.dart';
import 'package:small_talk/screens/home/profile.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference

  final CollectionReference userProfile =
      Firestore.instance.collection('profile');

  Future updateUserProfile(
      String username, String bio, String image, String id) async {
    return await userProfile.document(uid).setData({
      'username': username,
      'bio': bio,
      'image': image,
      "id": id,
    });
  }

  //Profiel from snapshot
  List<UserProfile> _profilesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserProfile(
        username: doc.data['username'] ?? '',
        bio: doc.data['bio'] ?? '',
        image: doc.data['image'] ?? "",
        id: doc.data['id'] ?? "",
      );
    }).toList();
  }

  //get profile

  Stream<List<UserProfile>> get profile {
    return userProfile.snapshots().map(_profilesFromSnapshot);
  }
}
