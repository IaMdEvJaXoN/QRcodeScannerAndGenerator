import 'dart:math';

class HomescreenText {
  HomescreenText._();

  static const List<String> morningTexts = [
    "Rise and Scan!",
    "Ready to decode the day?",
    "Scan first, coffee second.",
    "Let's make some QR magic.",
    "Morning! What's hiding in that QR?",
    "Fresh day, fresh scans.",
    "Time to turn squares into secrets.",
  ];
  static const List<String> afternoonTexts = [
    "Still scanning? Nice.",
    "QRs won't decode themselves.",
    "Let's create something scannable.",
    "Another QR adventure?",
    "Halfway through the day, fully charged.",
    "Keep calm and scan on.",
    "Welcome back, QR explorer.",
  ];
  static const List<String> eveningTexts = [
    "Evening scans hit differently.",
    "Wrapping up or just getting started?",
    "One last scan?",
    "Let's decode the evening.",
    "Time to create a few more QR codes.",
    "Night mode looks good on you.",
  ];

  static const List<String> nightTexts = [
    "Burning the midnight pixels?",
    "Late-night QR wizard, huh?",
    "The QRs never sleep.",
    "Scanning after dark.",
    "Night owl detected.",
    "Don't let the QR bugs bite.",
    "Still awake? Let's scan anyway.",
  ];

  

  static String getText(DateTime now) {
    final random = Random();
    if (now.hour >= 5 && now.hour <= 11) {
      final funnyGreeting = morningTexts[random.nextInt(morningTexts.length)];
      return funnyGreeting;
    } else if (now.hour >= 12 && now.hour <= 16) {
      final funnyGreeting = afternoonTexts[random.nextInt(afternoonTexts.length)];
      return funnyGreeting;
    } else if (now.hour >= 17 && now.hour <= 20) {
      final funnyGreeting = eveningTexts[random.nextInt(eveningTexts.length)];
      return funnyGreeting;
    } else {
      final funnyGreeting = nightTexts[random.nextInt(nightTexts.length)];
      return funnyGreeting;
    }
  }
}
