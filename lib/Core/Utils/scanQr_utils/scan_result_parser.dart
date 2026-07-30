import 'package:flutter/material.dart';
import 'package:proscan/Core/Utils/scanQr_utils/combine_time_and_payload.dart';
import 'package:proscan/Core/Utils/scanQr_utils/parsed_scan_result.dart';

class ScanResultParser {
  ScanResultParser._();

  static const String _delimiter = CombineTimeAndPayload.delimiter;

  static ParsedScanResult parse(String combinedRawString) {
    final splitIndex = combinedRawString.indexOf(_delimiter);

    final String timestamp = splitIndex != -1
        ? combinedRawString.substring(0, splitIndex)
        : '';
    final String rawValue = splitIndex != -1
        ? combinedRawString.substring(splitIndex + _delimiter.length)
        : combinedRawString;

    if (rawValue.startsWith('http://') || rawValue.startsWith('https://')) {
      return ParsedScanResult(
        payload: {'url': rawValue},
        contentType: 'Website',
        contentTypeIcon: Icons.language_rounded,
        timestamp: timestamp,
      );
    }

    if (rawValue.startsWith('tel:')) {
      return ParsedScanResult(
        payload: {'phone': rawValue.replaceFirst('tel:', '')},
        contentType: 'Phone',
        contentTypeIcon: Icons.call_rounded,
        timestamp: timestamp,
      );
    }

    if (rawValue.startsWith('mailto:')) {
      final uri = Uri.tryParse(rawValue);
      return ParsedScanResult(
        payload: {
          'email': uri?.path ?? rawValue.replaceFirst('mailto:', ''),
          'subject': uri?.queryParameters['subject'] ?? '',
          'body': uri?.queryParameters['body'] ?? '',
        },
        contentType: 'Email',
        contentTypeIcon: Icons.email_rounded,
        timestamp: timestamp,
      );
    }

    if (rawValue.startsWith('sms:')) {
      final uri = Uri.tryParse(rawValue);
      return ParsedScanResult(
        payload: {
          'phone': uri?.path ?? rawValue.replaceFirst('sms:', ''),
          'body': uri?.queryParameters['body'] ?? '',
        },
        contentType: 'SMS',
        contentTypeIcon: Icons.sms_rounded,
        timestamp: timestamp,
      );
    }

    if (rawValue.startsWith('geo:')) {
      final coords = rawValue.replaceFirst('geo:', '').split(',');
      return ParsedScanResult(
        payload: {
          'latitude': coords.isNotEmpty ? coords[0] : '',
          'longitude': coords.length > 1 ? coords[1] : '',
        },
        contentType: 'Location',
        contentTypeIcon: Icons.location_on_rounded,
        timestamp: timestamp,
      );
    }

    if (rawValue.startsWith('WIFI:')) {
      return ParsedScanResult(
        payload: _parseWifi(rawValue),
        contentType: 'Wi-Fi',
        contentTypeIcon: Icons.wifi_rounded,
        timestamp: timestamp,
      );
    }

    if (rawValue.startsWith('BEGIN:VCARD')) {
      return ParsedScanResult(
        payload: _parseVCard(rawValue),
        contentType: 'Contact',
        contentTypeIcon: Icons.person_rounded,
        timestamp: timestamp,
      );
    }

    if (rawValue.startsWith('BEGIN:VEVENT')) {
      return ParsedScanResult(
        payload: _parseVEvent(rawValue),
        contentType: 'Calendar',
        contentTypeIcon: Icons.event_rounded,
        timestamp: timestamp,
      );
    }

    return ParsedScanResult(
      payload: {'text': rawValue},
      contentType: 'Text',
      contentTypeIcon: Icons.notes_rounded,
      timestamp: timestamp,
    );
  }

  static Map<String, String> _parseWifi(String rawValue) {
    final body = rawValue.replaceFirst('WIFI:', '');
    final fields = <String, String>{};

    for (final segment in body.split(';')) {
      if (segment.isEmpty) continue;
      final separatorIndex = segment.indexOf(':');
      if (separatorIndex == -1) continue;

      final key = segment.substring(0, separatorIndex);
      final value = segment.substring(separatorIndex + 1);

      switch (key) {
        case 'S':
          fields['ssid'] = value;
          break;
        case 'P':
          fields['password'] = value;
          break;
        case 'T':
          fields['encryption'] = value;
          break;
      }
    }

    return fields;
  }

  static Map<String, String> _parseVCard(String rawValue) {
    final fields = <String, String>{};
    final lines = rawValue.split('\n');

    for (final line in lines) {
      if (line.startsWith('FN:')) {
        fields['name'] = line.replaceFirst('FN:', '').trim();
      } else if (line.startsWith('TEL:')) {
        fields['phone'] = line.replaceFirst('TEL:', '').trim();
      } else if (line.startsWith('EMAIL:')) {
        fields['email'] = line.replaceFirst('EMAIL:', '').trim();
      } else if (line.startsWith('ORG:')) {
        fields['company'] = line.replaceFirst('ORG:', '').trim();
      } else if (line.startsWith('URL:')) {
        fields['website'] = line.replaceFirst('URL:', '').trim();
      }
    }

    return fields;
  }

  static Map<String, String> _parseVEvent(String rawValue) {
    final fields = <String, String>{};
    final lines = rawValue.split('\n');

    for (final line in lines) {
      if (line.startsWith('SUMMARY:')) {
        fields['title'] = line.replaceFirst('SUMMARY:', '').trim();
      } else if (line.startsWith('LOCATION:')) {
        fields['location'] = line.replaceFirst('LOCATION:', '').trim();
      } else if (line.startsWith('DTSTART:')) {
        fields['start'] = line.replaceFirst('DTSTART:', '').trim();
      } else if (line.startsWith('DTEND:')) {
        fields['end'] = line.replaceFirst('DTEND:', '').trim();
      }
    }

    return fields;
  }
}
