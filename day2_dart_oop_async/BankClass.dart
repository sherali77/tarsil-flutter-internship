class BankAccount {
  double _balance = 0.0;
  double get Getbalance => _balance;
  void deposit(double amount){
    if (amount>0){
      _balance = _balance + amount;
    } else {
      print('Invalid Amount!');
    }
  }
  void withdrawl(double amount){
    if (amount<=0){
      print('Invalid Amount!');
    } else if (_balance>=amount){
      _balance = _balance - amount;
    } else {
      print('Insufficient amount');
    }
  }
}
class SavingsAccount extends BankAccount{
  double intrestRate;
  SavingsAccount(this.intrestRate);
  void addIntrest(){
    double result = (_balance * intrestRate)/100;
    deposit(result);
  }
}