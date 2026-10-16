import 'BankClass.dart';
import 'ShapeClass.dart';

void main() {
  //part 1&2
  SavingsAccount s = SavingsAccount();
  s.Deposit = 5000;
  s.addIntrest();
  s.Withdrawl(100000);
  print(s.getBalance);
  //part3
  Circle c = Circle();
  Rectangle r = Rectangle();
  print(c.Calculate_Area());
  print(r.Calculate_Area());
}
