import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<String?> initNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    String? fCMToken = await _firebaseMessaging.getToken();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return fCMToken;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      return fCMToken;
    } else {
      return fCMToken = null;
    }
  }
}
