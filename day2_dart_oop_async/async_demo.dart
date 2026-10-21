// part 1
Future<String> fetchUserName() async {
  print('Loading...');
  await Future.delayed(Duration(seconds: 1));
  return "Username fetched successfully";
}

//part 2
Future<void> fetchWeatherData() async {
  try {
    print('Fetching weather data...');
    await Future.delayed(Duration(seconds: 1));
    throw "Internet connection failed!";
  } catch (error) {
    print("Error: $error");
  }
}
//part 3
Stream<int> Countdown(int i) async* {
  for ( int j = i; j >= 0; j--) {
    await Future.delayed(Duration(seconds: 1));
    yield j;
  }
}

void main() async {
  print("main function is running");
  String data = await fetchUserName();
  print(data);
  await fetchWeatherData();
  await for (int value in Countdown(5)) {
    print('New value from STream $value');
  }
  print("main function is completed");
}
