import 'package:proscan/Features/CreateQR/Presentation/Widgets/QR_generator_widgets/qr_input_form.dart';

class QrEncoder {
  QrEncoder._();

  static String encode(QrFormType type, Map<String, String> values) {
    switch (type) {
      case QrFormType.website:
        return values['url'] ?? '';

      case QrFormType.clipboard:
      case QrFormType.text:
        return values['text'] ?? '';

      case QrFormType.wifi:
        final ssid = values['ssid'] ?? '';
        final password = values['password'] ?? '';
        final encryption = (values['encryption'] ?? 'WPA').toUpperCase();
        return 'WIFI:T:$encryption;S:$ssid;P:$password;;';

      case QrFormType.email:
        final email = values['email'] ?? '';
        final subject = Uri.encodeComponent(values['subject'] ?? '');
        final body = Uri.encodeComponent(values['body'] ?? '');
        return 'mailto:$email?subject=$subject&body=$body';

      case QrFormType.sms:
        final phone = values['phone'] ?? '';
        final body = Uri.encodeComponent(values['body'] ?? '');
        return 'sms:$phone?body=$body';

      case QrFormType.phone:
        return 'tel:${values['phone'] ?? ''}';

      case QrFormType.contact:
      case QrFormType.myCard:
        final name = values['name'] ?? '';
        final phone = values['phone'] ?? '';
        final email = values['email'] ?? '';
        final company = values['company'] ?? '';
        final extra = values['website'] ?? values['title'] ?? '';
        return 'BEGIN:VCARD\n'
            'VERSION:3.0\n'
            'FN:$name\n'
            'TEL:$phone\n'
            'EMAIL:$email\n'
            'ORG:$company\n'
            'URL:$extra\n'
            'END:VCARD';

      case QrFormType.calendar:
        final title = values['title'] ?? '';
        final location = values['location'] ?? '';
        final start = values['start'] ?? '';
        final time = values['time'] ?? '';
        return 'BEGIN:VEVENT\n'
            'SUMMARY:$title\n'
            'LOCATION:$location\n'
            'DTSTART:${start}T$time\n'
            'END:VEVENT';

      case QrFormType.paypal:
        return 'https://paypal.me/${values['username'] ?? ''}';

      case QrFormType.facebook:
      case QrFormType.youtube:
      case QrFormType.spotify:
        return values['url'] ?? '';

      case QrFormType.whatsapp:
        final phone = values['phone'] ?? '';
        final message = Uri.encodeComponent(values['message'] ?? '');
        return 'https://wa.me/$phone?text=$message';

      case QrFormType.instagram:
        return 'https://instagram.com/${values['username'] ?? ''}';

      case QrFormType.x:
        return 'https://x.com/${values['username'] ?? ''}';

      case QrFormType.viber:
        return 'viber://chat?number=${values['phone'] ?? ''}';
    }
  }
}
