String getGrade(int marks) {
  String grade = '';
  if (marks < 0 || marks > 100) {
    grade = 'invalid';
  } else if (marks >= 90 && marks <= 100) {
    grade = 'A';
  } else if (marks >= 80 && marks <= 89) {
    grade = 'B';
  } else if (marks >= 70 && marks <= 79) {
    grade = 'C';
  } else if (marks >= 60 && marks <= 69) {
    grade = 'D';
  } else if (marks < 60) {
    grade = 'F';
  }
  return grade;
}

void main() {
  //part 1
  for (int i = 1; i <= 100; i++) {
    if (i % 3 == 0 && i % 5 == 0) {
      print('fizzbuzz');
    } else if (i % 3 == 0) {
      print('fizz');
    } else if (i % 5 == 0) {
      print('buzz');
    } else {
      print('$i');
    }
  }
  //part 2&3
  print(getGrade(-1));
  print(getGrade(50));
  print(getGrade(65));
  print(getGrade(72));
  print(getGrade(88));
  print(getGrade(90));
  print(getGrade(101));
}
