class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String email;
  final String uid;
  final String username;
  final String bio;
  final String image;
  final List favorites;

  UserData({this.email, this.uid, this.username, this.bio, this.image, this.favorites});
}
