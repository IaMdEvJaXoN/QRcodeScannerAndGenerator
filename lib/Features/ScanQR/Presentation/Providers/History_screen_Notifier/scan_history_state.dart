class ScanHistoryState {
  final int id;
  final Map<String, String> payload;
  final String contentType;
  final String timeStamp;
  ScanHistoryState({
    required this.id,
    required this.payload,
    required this.contentType,
    required this.timeStamp,
  });
  // ScanHistoryState copyWith({
  //   int? id,
  //   Map<String, String>? payload,
  //   String? contentType,
  //   String? timeStamp,
  // }) {
  //   return ScanHistoryState(
  //     id: id ?? this.id,
  //     payload: payload ?? this.payload,
  //     contentType: contentType ?? this.contentType,
  //     timeStamp: timeStamp ?? this.timeStamp,
  //   );
  // }
}
