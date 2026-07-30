import 'package:flutter/material.dart';

class ScanResultUiMapper {
  ScanResultUiMapper._();

  static String verificationLabel(String contentType, String decodedContent) {
    bool isWebSecure = false;
    if (contentType == 'Website') {
      isWebSecure = decodedContent.contains('https://');
    }

    switch (contentType) {
      case 'Website':
        if (isWebSecure) {
          return 'Verified HTTPS';
        } else {
          return 'HTTP';
        }

      case 'Wi-Fi':
        return 'Encrypted Wi-Fi';
      case 'Phone':
        return 'Phone Number';
      case 'Email':
        return 'Email Address';
      case 'SMS':
        return 'Text Message';
      case 'Contact':
        return 'Contact Card';
      case 'Calendar':
        return 'Calendar Event';
      case 'Location':
        return 'Map Coordinates';
      case 'Text':
        return 'Plain Text';
      default:
        return 'Unknown Format';
    }
  }

  static String primaryActionLabel(String contentType) {
    switch (contentType) {
      case 'Website':
        return 'Open Website';
      case 'Phone':
        return 'Call Number';
      case 'Email':
        return 'Send Email';
      case 'SMS':
        return 'Send Message';
      case 'Location':
        return 'Open Maps';
      case 'Wi-Fi':
        return 'Connect Wi-Fi';
      case 'Calendar':
        return 'Add Event';
      case 'Contact':
        return 'Add Contact';
      case 'Text':
        return 'Search Text';
      default:
        return 'View Details';
    }
  }

  static IconData primaryActionIcon(String contentType) {
    switch (contentType) {
      case 'Website':
        return Icons.open_in_new_rounded;
      case 'Phone':
        return Icons.call_rounded;
      case 'Email':
        return Icons.email_rounded;
      case 'SMS':
        return Icons.sms_rounded;
      case 'Location':
        return Icons.map_rounded;
      case 'Wi-Fi':
        return Icons.wifi_rounded;
      case 'Calendar':
        return Icons.event_rounded;
      case 'Contact':
        return Icons.person_add_rounded;
      case 'Text':
        return Icons.search_rounded;
      default:
        return Icons.info_outline_rounded;
    }
  }

  static String statusTitle(String contentType, String decodedContent) {
    bool isWebSecure = false;
    if (contentType == 'Website') {
      isWebSecure = decodedContent.contains('https://');
    }
    switch (contentType) {
      case 'Website':
        if (isWebSecure) {
          return 'Secure';
        } else {
          return 'Insecure';
        }

      case 'Wi-Fi':
        return 'Encrypted';
      default:
        return 'Unverified';
    }
  }

  static String statusDescription(String contentType, String decodedContent) {
    bool isWebSecure = false;
    if (contentType == 'Website') {
      isWebSecure = decodedContent.contains('https://');
    }
    switch (contentType) {
      case 'Website':
        if (isWebSecure) {
          return 'Verified HTTPS';
        } else {
          return 'HTTP';
        }

      case 'Wi-Fi':
        return 'Private Network';
      default:
        return 'Unknown Source';
    }
  }

  static IconData statusIcon(String contentType) {
    switch (contentType) {
      case 'Website':
      case 'Wi-Fi':
        return Icons.verified_user_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }
}
