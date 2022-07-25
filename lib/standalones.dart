String getTime() {
  var now = DateTime.now();

  if (now.hour >= 4 && now.hour < 12) {
    return "Morning";
  } else if (now.hour >= 12 && now.hour < 17) {
    return "Afternoon";
  } else if (now.hour >= 17 && now.hour < 22) {
    return "Evening";
  } else if (now.hour >= 22 || now.hour < 4) {
    return "Night";
  } else {
    return "Day";
  }
}
