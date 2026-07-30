import 'package:flutter/material.dart';

class QrFormTypeIconMapper {
  QrFormTypeIconMapper._();

  static IconData getIcon(String qrFormType) {
    final type = qrFormType.split('.').last.toLowerCase();

    switch (type) {
      case 'website':
      case 'facebook':
      case 'youtube':
      case 'instagram':
      case 'spotify':
      case 'x':
        return Icons
            .language_rounded; // Because i want IconData,i'm avoiding FalconData here do i'm just using generic icons

      case 'wifi':
        return Icons.wifi_rounded;

      case 'email':
        return Icons.email_rounded;

      case 'sms':
        return Icons.sms_rounded;

      case 'phone':
        return Icons.phone_rounded;

      case 'contact':
      case 'mycard':
        return Icons.contact_page_rounded;

      case 'calendar':
        return Icons.calendar_today_rounded;

      case 'paypal':
        return Icons.payments_rounded;

      case 'whatsapp':
      case 'viber':
        return Icons.chat_rounded;

      case 'clipboard':
        return Icons.content_paste_rounded;

      case 'text':
        return Icons.text_fields_rounded;

      default:
        return Icons.qr_code_rounded;
    }
  }
}
