`import 'dart:math';

void main(){
  var rect = Rectangle(10.0, 5.0);
  print('${rect.area()}');
  print('${rect.ratio()}');
}

class Rectangle{
  final num length;
  final num breadth;

  Rectangle(this.length, this.breadth);

  num get diagonal => sqrt(length * length + breadth * breadth);
  num area(){
    return length * breadth;
  }
  num ratio(){
    num dia = min(length, breadth);
    num rad = dia / 2;
    num areaC = pi * rad * rad;
    num areaR = area();
    return areaR / areaC;
  }
}