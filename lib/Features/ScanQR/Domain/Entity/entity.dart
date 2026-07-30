class ScanHistoryEntity {
  final int id;
  final Map<String, String> payLoad;
  final String contentType;
  final String timeStamp;
  ScanHistoryEntity({
    required this.id,
    required this.payLoad,
    required this.contentType,
    required this.timeStamp,
  });
}
