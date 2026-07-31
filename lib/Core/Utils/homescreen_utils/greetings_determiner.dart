class GreetingsDeterminer {
  GreetingsDeterminer._();
  static String determineGreeting(DateTime now) {
    final hour = now.hour; //24 hour clock system
    if (hour >= 5 && hour <= 11) {
      return "Good Morning";
    } else if (hour >= 12 && hour <= 16) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour <= 20) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }
}
