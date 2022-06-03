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

  static SocketMsg convertObjectTo(Map<dynamic, dynamic> object) {
    SocketMsg newObject = SocketMsg(
      kdsMessageType: object['kdsMessageType'],
      kdsList: object['kdsList'],
    );
    return newObject;
  }
}
