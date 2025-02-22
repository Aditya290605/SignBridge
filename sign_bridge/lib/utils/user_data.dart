import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static String? name;

  static Future<void> fetchUserName(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance
              .collection('userInfo')
              .doc(userId)
              .get();

      if (userDoc.exists) {
        name = userDoc['name'];
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
  }
}
