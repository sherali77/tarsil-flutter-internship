import 'dart:io';

abstract class Shape {
  double Calculate_Area();
}

class Circle extends Shape {
  double radius = 2;
  double pi = 3.14;
  @override
  double Calculate_Area() {
    double area = pi * radius * radius;
    return area;
  }
}
class Rectangle extends Shape {
  double len = 2;
  double wid = 3;
  @override
  double Calculate_Area() {
    double area = len*wid;
    return area;
  }
}