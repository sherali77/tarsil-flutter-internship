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
  bool hasMilk = shoppings.contains("milk");
  print(hasMilk);
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
    print('${item.key} ${item.value}');
    sum += item.value;
  }
    avg = sum / marks.length;
  // print(marks);
  print(avg);
  var topStudent = marks.entries.reduce((a, b) => a.value > b.value ? a : b);
  print(
    '${topStudent.key} is the top student with the marks: ${topStudent.value} !',
  );
  //part 3
  Set<String> colors = {'red', 'green', 'blue'};
  colors.add('red');
  print(colors);
  //as i added color red but it shows only 3 items because red alredy exists.
}
