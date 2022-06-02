class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
  //final RemoteMessage? remoteMessage;

  CustomNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    //this.remoteMessage,
  });
}
