import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

//////////////////////
//   알림 권한 요청  //
//////////////////////

Future<bool> requestNotification() async{
  late bool isNotificationChecked;

  // Android
  await Permission.notification.request();
  PermissionStatus status = await Permission.notification.status;
  
  // iOS
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // 권한 확인
  if (Platform.isAndroid) {
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      isNotificationChecked = true;
    } else {
      isNotificationChecked = false;
    }
  } else if (Platform.isIOS){
    if (status.isGranted == true) {
      isNotificationChecked = true;
    } else {
      isNotificationChecked = false;
    }
  }

  print("안드로이드 알림 권한: ${status.isGranted}");
  print('iOS 알림 권한: ${settings.authorizationStatus}');
  print(isNotificationChecked);

  return isNotificationChecked;
}