double calculate_Bill({required double amount, double tipPercentage = 10}) {
  double tipAmount = amount * (tipPercentage / 100);
  double totalBill = amount + tipAmount;
  return totalBill;
}

bool isEven(int n) => n % 2 == 0;
void main() {
  //part 1
  print(calculate_Bill(amount: 100));
  print(calculate_Bill(amount: 100, tipPercentage: 30));
  //part 2
  print(isEven(5));
  print(isEven(4));
  //part 3
  List<int> numbers = [3, 8, 12, 5, 7, 20];
  var evens = numbers.where((n) => n % 2 == 0).toList();
  print('$evens is the list of evens');
  var squares = numbers.map((n) => n * n).toList();
  print('$squares is the list of squares of numbers');
  var sum = numbers.reduce((value, element) => value + element);
  print('$sum is the sum of list numbers');
}
