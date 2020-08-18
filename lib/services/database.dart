import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:small_talk/models/user.dart';
import 'package:small_talk/models/user_profile.dart';
import 'package:small_talk/shared/helper_functions.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference

  final CollectionReference userProfiles =
      Firestore.instance.collection('profile');

  Future updateUserProfile(
      String email, String username, String bio, String image, String id, List favorites) async {

    HelperFunctions.saveUsernameSharedPreference(username);
    HelperFunctions.saveUserImageSharedPreference(image);

    return await userProfiles.document(uid).setData({
      'email': email,
      'username': username,
      'bio': bio,
      'image': image,
      "id": id,
      "favorites": favorites,
    });
  }

  //Profile from snapshot
  List<UserProfile> _profilesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserProfile(
        email: doc.data['email'] ?? '',
        username: doc.data['username'] ?? '',
        bio: doc.data['bio'] ?? '',
        image: doc.data['image'] ?? "",
        id: doc.data['id'] ?? "",
        favorites: doc.data['favorites'],
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
      email: snapshot.data['email'],
      username: snapshot.data['username'],
      bio: snapshot.data['bio'],
      image: snapshot.data['image'],
      favorites: snapshot.data['favorites'],
    );
  }

  // get user doc stream

  Stream<UserData> get userData {
    return userProfiles.document(uid).snapshots()
        .map(userDataFromSnapShot);
  }

  getUserByUsername(String username) async {
    return await Firestore.instance.collection('profile')
        .where("username", isEqualTo: username)
        .getDocuments();
  }

  getUserByUid(String uid) async {
    return await Firestore.instance.collection('profile')
        .where("uid", isEqualTo: uid)
        .getDocuments();
  }

  getUserByEmail(String email) async {
    return await Firestore.instance.collection('profile')
        .where("email", isEqualTo: email)
        .getDocuments();
  }

  createConversation(String conversationId, conversationMap) {
    try{
      Firestore.instance.collection('conversation')
          .document(conversationId).setData(conversationMap);
    } catch(e) {
      print(e.toString());
    }
  }

  addConversationMessages(String  conversationId, messageMap) {
    Firestore.instance.collection('conversation')
        .document(conversationId)
        .collection('messages')
        .add(messageMap).catchError((e) {print(e.toString());});
  }

  getConversationMessages(String  conversationId) async {
    return await Firestore.instance.collection('conversation')
        .document(conversationId)
        .collection('messages')
        .orderBy("time", descending: false)
        .snapshots();
  }

  getUserConversations(String uid) async {
    return await Firestore.instance.collection('conversation')
        .where("userIds", arrayContains: uid)
        .orderBy("time", descending: true)
        .snapshots();
  }

  getTopics()async{
    return await Firestore.instance.collection('topics')
        .orderBy("topic")
        .snapshots();
  }

}
