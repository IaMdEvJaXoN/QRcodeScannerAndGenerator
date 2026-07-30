import 'package:proscan/Features/CreateQR/Presentation/Widgets/QR_generator_widgets/qr_input_form.dart';

class MapTitleToFormtype {
  MapTitleToFormtype._();
  static QrFormType mapTitleToFormType(String title) {
    switch (title) {
      case 'Website':
        return QrFormType.website;
      case 'Clipboard':
        return QrFormType.clipboard;
      case 'Wi-Fi':
        return QrFormType.wifi;
      case 'Text':
        return QrFormType.text;
      case 'Email':
        return QrFormType.email;
      case 'SMS':
        return QrFormType.sms;
      case 'Phone':
        return QrFormType.phone;
      case 'Contacts':
        return QrFormType.contact;
      case 'Calendar':
        return QrFormType.calendar;
      case 'My Card':
        return QrFormType.myCard;
      case 'PayPal':
        return QrFormType.paypal;
      case 'Facebook':
        return QrFormType.facebook;
      case 'YouTube':
        return QrFormType.youtube;
      case 'WhatsApp':
        return QrFormType.whatsapp;
      case 'Instagram':
        return QrFormType.instagram;
      case 'X':
        return QrFormType.x;
      case 'Spotify':
        return QrFormType.spotify;
      case 'Viber':
        return QrFormType.viber;
      default:
        return QrFormType.text;
    }
  }
}
