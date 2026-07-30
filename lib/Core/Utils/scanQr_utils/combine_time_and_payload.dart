class CombineTimeAndPayload {
  CombineTimeAndPayload._();
  static const String delimiter = "|||";
  static String combine(String timeStamp, String rawValue) {
    return "$timeStamp$delimiter$rawValue";
  }
}
