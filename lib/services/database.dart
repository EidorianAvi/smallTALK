import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/models/user_profile.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference

  final CollectionReference userProfiles =
      Firestore.instance.collection('profile');

  Future updateUserProfile(
      String username, String bio, String image, String id) async {
    return await userProfiles.document(uid).setData({
      'username': username,
      'bio': bio,
      'image': image,
      "id": id,
    });
  }

  //Profile from snapshot
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

  Stream<List<UserProfile>> get profiles {
    return userProfiles.snapshots().map(_profilesFromSnapshot);
  }

  // UserData from snapshot
  UserData userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      bio: snapshot.data['bio'],
      image: snapshot.data['image'],
    );
  }

  // get user doc stream

  Stream<UserData> get userData {
    return userProfiles.document(uid).snapshots()
        .map(userDataFromSnapShot);
  }

  // find user by username

  getUserByUsername(String username) async {
    return await Firestore.instance.collection('profile')
        .where("username", isEqualTo: username)
        .getDocuments();
  }

  //Used to create a conversation instance

  createConversation(String conversationId, conversationMap) {
    try{
      Firestore.instance.collection('conversation')
          .document(conversationId).setData(conversationMap);
    } catch(e) {
      print(e.toString());
    }
  }

}
