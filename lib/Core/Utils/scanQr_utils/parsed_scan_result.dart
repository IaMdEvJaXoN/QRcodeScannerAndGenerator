import 'package:flutter/material.dart';

class ParsedScanResult {
  final Map<String, String> payload;
  final String contentType;
  final IconData contentTypeIcon;
  final String timestamp;

  const ParsedScanResult({
    required this.payload,
    required this.contentType,
    required this.contentTypeIcon,
    required this.timestamp,
  });
}
