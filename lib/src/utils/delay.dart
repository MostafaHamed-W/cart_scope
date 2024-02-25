Future<void> delay(bool isDelayed, [int duration = 2000]) async {
  if (isDelayed) {
    return Future.delayed(Duration(milliseconds: duration));
  } else {
    return Future.value();
  }
}
