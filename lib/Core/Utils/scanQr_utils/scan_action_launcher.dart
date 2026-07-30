import 'package:app_settings/app_settings.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanActionLauncher {
  ScanActionLauncher._();

  static Future<void> performPrimaryAction(
    String contentType,
    Map<String, String> payload,
  ) async {
    Uri? uri;

    switch (contentType) {
      case 'Website':
        uri = Uri.tryParse(payload['url'] ?? '');
        break;
      case 'Phone':
        uri = Uri(scheme: 'tel', path: payload['phone']);
        break;
      case 'Email':
        uri = Uri(
          scheme: 'mailto',
          path: payload['email'],
          queryParameters: {
            if ((payload['subject'] ?? '').isNotEmpty)
              'subject': payload['subject']!,
            if ((payload['body'] ?? '').isNotEmpty) 'body': payload['body']!,
          },
        );
        break;
      case 'SMS':
        uri = Uri(
          scheme: 'sms',
          path: payload['phone'],
          queryParameters: {
            if ((payload['body'] ?? '').isNotEmpty) 'body': payload['body']!,
          },
        );
        break;
      case 'Location':
        uri = Uri.parse('geo:${payload['latitude']},${payload['longitude']}');
        break;
      case 'Wi-Fi':
        await AppSettings.openAppSettings(type: AppSettingsType.wifi);
        return;
      case 'Text':
        uri = Uri(
          scheme: 'https',
          host: 'www.google.com',
          path: '/search',
          queryParameters: {'q': payload['text'] ?? ''},
        );
        break;
      default:
        return;
    }

    if (uri == null) return;

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
