void main() {
  //part 1
  String name = "Sher Ali";
  int age = 24;
  double height = 5.7;
  bool isStudent = true;
  if (isStudent) {
    print(
      "My name is $name. I am $age years old and my height is $height feet.",
    );
  } else {
    print("Not a student");
  }
  //part 2
  //Difference between final and const
  //Both final and const are used to declare variables that cannot be reassigned but the diffrence is that we assigned the value of const in compile time.
  // But in the final we assign the value at runtime.
  const pi = 3.141;
  final area;
  double len = 2, wid = 2;
  area = len * wid;
  print("The constant is $pi and the final is $area");
  //part 3
  String? nickname = "sheru";
  print(nickname.length ?? 0);
}
