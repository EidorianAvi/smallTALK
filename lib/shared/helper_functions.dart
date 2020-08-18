import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  static String sharedPreferenceUserEmailKey = "USEREMAIL";
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserUsernameKey = "USERUSERNAMEKEY";
  static String sharedPreferenceUserImageKey = "USERIMAGEKEY";
  static String sharedPreferenceUserBioKey = "USERBIOKEY";
  static String sharedPreferenceUserFavoritesKey = "USERFAVORITESKEY";
  static String sharedPreferenceUserUidKey = "USERUIDKEY";


  // grabs shared preferences
  static Future<void> saveUserEmailSharedPreference(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, email);
  }
  static Future<void> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }
  static Future<void> saveUsernameSharedPreference(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserUsernameKey, username);
  }
  static Future<void> saveUserImageSharedPreference(String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserImageKey, image);
  }
  static Future<void> saveUserBioSharedPreference(String bio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserBioKey, bio);
  }
  static Future<void> saveUserFavoritesSharedPreference(List favorites) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(sharedPreferenceUserFavoritesKey, favorites);
  }
  static Future<void> saveUserUidSharedPreference(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserUidKey, uid);
  }

  //grabs data from shared preferences
  static Future<String> getUserEmailSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmailKey);
  }
  static Future<bool> getUserLoggedInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserLoggedInKey);
  }
  static Future<String> getUsernameSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserUsernameKey);
  }
  static Future<String> getUserImageSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserImageKey);
  }
  static Future<String> getUserBioSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserBioKey);
  }
  static Future<List<String>> getUserFavoritesSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(sharedPreferenceUserFavoritesKey);
  }
  static Future<String> getUserUidSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserUidKey);
  }
}
