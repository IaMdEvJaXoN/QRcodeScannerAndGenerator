import 'package:flutter/material.dart';

enum QrFormType {
  website,
  clipboard,
  wifi,
  text,
  email,
  sms,
  phone,
  contact,
  calendar,
  myCard,
  paypal,
  facebook,
  youtube,
  whatsapp,
  instagram,
  x,
  spotify,
  viber,
}

class QrInputForm extends StatefulWidget {
  final QrFormType formType;
  final ValueChanged<Map<String, String>> onChanged;

  const QrInputForm({
    super.key,
    required this.formType,
    required this.onChanged,
  });

  @override
  State<QrInputForm> createState() => _QrInputFormState();
}

class _QrInputFormState extends State<QrInputForm> {
  late final List<_FieldSpec> _fields;
  late final Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _fields = _fieldsForType(widget.formType);
    _controllers = {
      for (final field in _fields) field.key: TextEditingController(),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _emitValues() {
    widget.onChanged({
      for (final entry in _controllers.entries) entry.key: entry.value.text,
    });
  }

  static List<_FieldSpec> _fieldsForType(QrFormType type) {
    switch (type) {
      case QrFormType.website:
        return const [
          _FieldSpec(
            key: 'url',
            label: 'Website URL',
            icon: Icons.language_rounded,
          ),
        ];
      case QrFormType.clipboard:
        return const [
          _FieldSpec(
            key: 'text',
            label: 'Clipboard Content',
            icon: Icons.content_paste_rounded,
            maxLines: 4,
          ),
        ];
      case QrFormType.wifi:
        return const [
          _FieldSpec(key: 'ssid', label: 'SSID', icon: Icons.wifi_rounded),
          _FieldSpec(
            key: 'password',
            label: 'Password',
            icon: Icons.lock_outline_rounded,
          ),
          _FieldSpec(
            key: 'encryption',
            label: 'Encryption (WPA/WEP/nopass)',
            icon: Icons.security_rounded,
          ),
        ];
      case QrFormType.text:
        return const [
          _FieldSpec(
            key: 'text',
            label: 'Text',
            icon: Icons.notes_rounded,
            maxLines: 6,
          ),
        ];
      case QrFormType.email:
        return const [
          _FieldSpec(
            key: 'email',
            label: 'Recipient',
            icon: Icons.email_rounded,
          ),
          _FieldSpec(
            key: 'subject',
            label: 'Subject',
            icon: Icons.subject_rounded,
          ),
          _FieldSpec(
            key: 'body',
            label: 'Message',
            icon: Icons.message_rounded,
            maxLines: 4,
          ),
        ];
      case QrFormType.sms:
        return const [
          _FieldSpec(
            key: 'phone',
            label: 'Phone Number',
            icon: Icons.call_rounded,
          ),
          _FieldSpec(
            key: 'body',
            label: 'Message',
            icon: Icons.message_rounded,
            maxLines: 4,
          ),
        ];
      case QrFormType.phone:
        return const [
          _FieldSpec(
            key: 'phone',
            label: 'Phone Number',
            icon: Icons.call_rounded,
          ),
        ];
      case QrFormType.contact:
        return const [
          _FieldSpec(key: 'name', label: 'Name', icon: Icons.person_rounded),
          _FieldSpec(key: 'phone', label: 'Phone', icon: Icons.call_rounded),
          _FieldSpec(key: 'email', label: 'Email', icon: Icons.email_rounded),
          _FieldSpec(
            key: 'company',
            label: 'Company',
            icon: Icons.business_rounded,
          ),
          _FieldSpec(
            key: 'website',
            label: 'Website',
            icon: Icons.language_rounded,
          ),
        ];
      case QrFormType.calendar:
        return const [
          _FieldSpec(key: 'title', label: 'Title', icon: Icons.event_rounded),
          _FieldSpec(
            key: 'location',
            label: 'Location',
            icon: Icons.location_on_rounded,
          ),
          _FieldSpec(
            key: 'start',
            label: 'Date (YYYYMMDD)',
            icon: Icons.calendar_today_rounded,
          ),
          _FieldSpec(
            key: 'time',
            label: 'Time (HHmm)',
            icon: Icons.access_time_rounded,
          ),
        ];
      case QrFormType.myCard:
        return const [
          _FieldSpec(key: 'name', label: 'Name', icon: Icons.person_rounded),
          _FieldSpec(key: 'phone', label: 'Phone', icon: Icons.call_rounded),
          _FieldSpec(key: 'email', label: 'Email', icon: Icons.email_rounded),
          _FieldSpec(
            key: 'company',
            label: 'Company',
            icon: Icons.business_rounded,
          ),
          _FieldSpec(
            key: 'title',
            label: 'Job Title',
            icon: Icons.badge_rounded,
          ),
        ];
      case QrFormType.paypal:
        return const [
          _FieldSpec(
            key: 'username',
            label: 'PayPal.me Username',
            icon: Icons.person_rounded,
          ),
        ];
      case QrFormType.facebook:
        return const [
          _FieldSpec(
            key: 'url',
            label: 'Facebook Profile URL',
            icon: Icons.link_rounded,
          ),
        ];
      case QrFormType.youtube:
        return const [
          _FieldSpec(
            key: 'url',
            label: 'YouTube Channel URL',
            icon: Icons.link_rounded,
          ),
        ];
      case QrFormType.whatsapp:
        return const [
          _FieldSpec(
            key: 'phone',
            label: 'Phone Number',
            icon: Icons.call_rounded,
          ),
          _FieldSpec(
            key: 'message',
            label: 'Prefilled Message (optional)',
            icon: Icons.message_rounded,
            maxLines: 3,
          ),
        ];
      case QrFormType.instagram:
        return const [
          _FieldSpec(
            key: 'username',
            label: 'Instagram Username',
            icon: Icons.person_rounded,
          ),
        ];
      case QrFormType.x:
        return const [
          _FieldSpec(
            key: 'username',
            label: 'X (Twitter) Username',
            icon: Icons.person_rounded,
          ),
        ];
      case QrFormType.spotify:
        return const [
          _FieldSpec(
            key: 'url',
            label: 'Spotify Track/Artist URL',
            icon: Icons.link_rounded,
          ),
        ];
      case QrFormType.viber:
        return const [
          _FieldSpec(
            key: 'phone',
            label: 'Phone Number',
            icon: Icons.call_rounded,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_fields.length * 2 - 1, (index) {
        if (index.isOdd) {
          return const SizedBox(height: 16);
        }
        final field = _fields[index ~/ 2];
        return TextField(
          controller: _controllers[field.key],
          maxLines: field.maxLines,
          onChanged: (_) => _emitValues(),
          decoration: InputDecoration(
            labelText: field.label,
            prefixIcon: Icon(field.icon),
          ),
        );
      }),
    );
  }
}

class _FieldSpec {
  final String key;
  final String label;
  final IconData icon;
  final int maxLines;

  const _FieldSpec({
    required this.key,
    required this.label,
    required this.icon,
    this.maxLines = 1,
  });
}
