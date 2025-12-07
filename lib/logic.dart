import 'dart:math';

int calculateLovePercentage(String maleName, String femaleName) {
  int value = 0;
  String combined = maleName.toLowerCase() + femaleName.toLowerCase();
  
  for (int i = 0; i < combined.length; i++) {
    value += combined.codeUnitAt(i);
  }

  return value % 101;
}

String getLoveMessage(int percentage) {
  final random = Random();

  if (percentage <= 20) {
    final options = [
      "❌ Even free airport WiFi has stronger connections than this.",
      "💀 Chemistry: Not Found. Try refreshing or update your status to 'Single'.",
      "🙅 0 chemistry. Even Coke and Mentos have more spark.",
      "🙅‍♂️ If love was an exam, this would be negative marking."
    ];
    return options[random.nextInt(options.length)];
  } else if (percentage <= 40) {
    final options = [
      "😬 There’s hope… kinda. Like when WiFi says 'connected, no internet'.",
      "😬 Y’all are like an expired OTP—didn’t quite work.",
      "🤷‍♂️ Could be love… or just two people avoiding boredom.",
      "😬 Y’all are like a weak password—easy to forget."
    ];
    return options[random.nextInt(options.length)];
  } else if (percentage <= 60) {
    final options = [
      "😏 The 'it’s complicated' stage… Zuckerberg would approve.",
      "🤔 Not bad, not great. Basically a 3-star Amazon review.",
      "☕ Got that situationship vibe… maybe just grab coffee first.",
      "😐 Works fine, but needs bug fixes every update."
    ];
    return options[random.nextInt(options.length)];
  } else if (percentage <= 80) {
    final options = [
      "💕 Cuteee. Like fries and ketchup—better together.",
      "🥰 Solid match! Your friends already gossip about you.",
      "💫 Rom-com level love. Netflix would greenlight this."
    ];
    return options[random.nextInt(options.length)];
  } else if (percentage <= 90) {
    final options = [
      "🔥 So strong, even horoscopes are like: 'Bruh. It’s fate.'",
      "❤️ Couple goals unlocked. TikTok edits incoming.",
      "💎 Low-key power couple. High-key everyone’s jealous."
    ];
    return options[random.nextInt(options.length)];
  } else {
    final options = [
      "💘 Soulmate alert! Go propose before someone else calculates this 😂",
      "🚀 101%?? Even Thanos couldn’t snap this bond.",
      "🎉 This isn’t love, this is WiFi password level secure."
    ];
    return options[random.nextInt(options.length)];
  }
}
