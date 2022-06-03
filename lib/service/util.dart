import 'dart:convert';

import '../model/socket_msg.dart';

class Util {
  static String createInitials(String inputString) {
    List<String> wordList = inputString.split(" ");
    if (wordList.isNotEmpty) {
      if (wordList.length == 1) {
        return wordList[0][0];
      } else if (wordList.length > 1) {
        return "${wordList[0][0]}${wordList[1][0]}";
      } else {
        return ' ';
      }
    } else {
      return ' ';
    }
  }

  static SocketMsg convertObjectTo(List<Object>? arguments) {
    var argsString = arguments?[2] as String;
    Map<String, dynamic> data = jsonDecode(argsString.trim());
    SocketMsg message = SocketMsg.fromJson(data);
    return message;
  }
}
