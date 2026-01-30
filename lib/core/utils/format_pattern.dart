class FormatPattern {
  String formatEveryNChars(String text, int n) {
    text = text.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % n == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }
    return buffer.toString();
  }

  String formatPattern3and4(String text) {
    text = text.replaceAll(' ', '');
    if (text.length <= 3) return text;
    String firstPart = text.substring(0, 3);
    String remainingPart = text.substring(3);

    String formattedRemaining = '';
    for (int i = 0; i < remainingPart.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedRemaining += ' ';
      }
      formattedRemaining += remainingPart[i];
    }
    return '$firstPart $formattedRemaining';
  }
}
