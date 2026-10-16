class BankAccount {
  double _balance = 0.0;
  double get getBalance {
    return _balance;
  }

  set Deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    } else {
      print('Invalid Amount!');
    }
  }

  double Withdrawl(double amount) {
    if (_balance >= amount && amount > 0) {
      _balance -= amount;
    } else {
      print('insufficient amount');
    }
    return _balance;
  }
}

class SavingsAccount extends BankAccount {
  double result = 0.0;
  void addIntrest() {
    double intrest_rate = _balance * 0.5;
    result = _balance + intrest_rate;
    _balance = result;
  }

  @override
  set Deposit(double amount) {
    if (amount > 0) {
      super.Deposit = amount;
    }
  }
}
