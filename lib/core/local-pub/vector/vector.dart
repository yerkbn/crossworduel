// ignore_for_file: unnecessary_parenthesis

import 'dart:math';

class Vector {
  final double x;
  final double y;

  const Vector(this.x, this.y);

  Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y);

  Vector multiply(num val) {
    return Vector(x * val, y * val);
  }

  Vector get getCopy {
    return Vector(x, y);
  }

  double distance(Vector b) {
    return sqrt(pow((b.x - x), 2) + pow((b.y - y), 2));
  }

  @override
  String toString() {
    return 'x = $x, y = $y';
  }

  Vector divide(num val) {
    return Vector(x / val, y / val);
  }
}
