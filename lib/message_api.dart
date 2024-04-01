import 'package:firebase_messaging/firebase_messaging.dart';

class MessageApi {
  // initialize the Firebase Messaging instance
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> init() async {
    // request permission to receive push notifications
    await _messaging.requestPermission();
    // get the token for this device
    final token = await _messaging.getToken();
    print('Token: $token');

    // initialize push notifications
    await initPushNotifications();
  }

  // handle incoming messages
  void handleMessages(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    print('Message data: ${message.data}');
  }

  // init push notifications
  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance.getInitialMessage().then(handleMessages);

    // attach the foreground message handler
    FirebaseMessaging.onMessage.listen(handleMessages);
  }
}
