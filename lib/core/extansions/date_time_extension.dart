extension FormatedDateTime on DateTime {
  String toFormattedString() {
    String dayString = day.toString().padLeft(2, '0');
    String monthString = day.toString().padLeft(2, '0');
    return "$dayString:$monthString:$year";
  }
}
