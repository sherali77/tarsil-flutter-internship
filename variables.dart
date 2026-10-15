void main() {
  //part 1
  String name = "Sher Ali";
  int age = 24;
  double height = 5.7;
  print("My name is $name. I am $age years old and my height is $height feet.");
  //part 2
  //Difference between final and const
  //Both final and const are used to declare variables that cannot be reassigned but the diffrence is that we assigned the value of const in compile time.
  // But in the final we assign the value at runtime.
  //part 3
  String? nickname;
  print(nickname ?? "the value is null");
  print(nickname?.length);
}
