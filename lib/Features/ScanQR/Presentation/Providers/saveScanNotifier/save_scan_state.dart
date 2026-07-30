class SaveScanState {
  final int id;
  final Map<String, String> payload;
  final String contentType;
  final String timeStamp;
  SaveScanState({
    required this.id,
    required this.payload,
    required this.contentType,
    required this.timeStamp,
  });
}
