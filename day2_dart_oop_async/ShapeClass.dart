// import 'dart:io';

abstract class Shape {
  double Calculate_Area();
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);
  double pi = 3.14;
  @override
  double Calculate_Area() {
    double area = pi * radius * radius;
    return area;
  }
}

class Rectangle extends Shape {
  double len;
  double wid;
  Rectangle(this.len, this.wid);
  @override
  double Calculate_Area() {
    double area = len * wid;
    return area;
  }
}
