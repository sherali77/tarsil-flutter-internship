import 'BankClass.dart';
import 'ShapeClass.dart';

void main() {
  //part 1&2
  SavingsAccount s = SavingsAccount(3);
  s.deposit(5000);
  s.addIntrest();
  s.withdrawl(100000);
  print(s.Getbalance);
  //part3
  List<Shape> shapes = [Circle(5), Rectangle(4,3)];
  for (var shape in shapes) {
    print('${shape.Calculate_Area()}');
  }
}
