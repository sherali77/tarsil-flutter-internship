void main() {
  //part 1
  List<String> shoppings = [];
  shoppings.add('bread');
  shoppings.add('biscuits');
  shoppings.add('milk');
  shoppings.add('juice');
  shoppings.add('chips');
  shoppings.remove('chips');
  for (var i = 0; i < shoppings.length; i++) {
    print("${shoppings[i]} $i");
  }
  for (var i = 0; i < shoppings.length; i++) {
    if (shoppings[i] == 'milk') {
      print('exists');
    }
  }
  //part 2
  Map<String, double> marks = {
    'sher': 50,
    'awais': 70,
    'ali': 30,
    'umar': 80,
    'hamza': 95,
  };
  double avg = 0;
  double sum = 0;
  for (var item in marks.entries) {
    sum += item.value;
    avg = sum / 5;
  }
  print(marks);
  print(avg);
  //part 3
  Set<String> colors = {'red', 'green', 'blue'};
  colors.add('red');
  print(colors);
  //as i added color red but it shows only 3 items because red alredy exists.
}
