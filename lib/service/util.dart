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
}
