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
      String email, String username, String bio, String image, String id, List favorites) async {

    return await userProfiles.document(uid).setData({
      'email': email,
      'username': username,
      'bio': bio,
      'image': image,
      "id": id,
      "favorites": favorites,
    });
  }

  Future updatePostStatus(String topic, String post) async {
    Firestore.instance.collection("topics")
        .document(topic)
        .collection("posts")
        .document(post)
        .updateData({"isTaken": true});
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
        .getDocuments().catchError((e) {print(e.toString());});
  }

  getUserByUid(String uid) async {
    return await Firestore.instance.collection('profile')
        .where("uid", isEqualTo: uid)
        .getDocuments().catchError((e) {print(e.toString());});
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

  createTopic(String topic){
    try{
      Firestore.instance.collection('topics')
          .document(topic)
          .setData({'topic name': topic});
    }catch(e){
      print(e.toString());
    }
  }

  createPost(String topic, postMap){
    try{
      Firestore.instance.collection('topics')
          .document(topic)
          .collection('posts')
          .document(postMap['post'])
          .setData(postMap);
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


  addUserToConnections(user, String loggedInUserUid) {
    Firestore.instance.collection('profile')
        .document(loggedInUserUid)
        .collection('connections')
        .add(user);
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

  getTopics() async{
    return await Firestore.instance.collection('topics')
        .orderBy('topic name')
        .snapshots();
  }

  getPosts(String topic) async{
    return await Firestore.instance.collection('topics')
        .document(topic)
        .collection("posts")
        .where('isTaken', isEqualTo: false)
        .snapshots();
  }

}
