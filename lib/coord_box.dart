class CoordBox {
  final double x;
  final double y;
  final double h;

  const CoordBox(this.x, this.y, this.h);

  @override
  String toString() {
    // TODO: implement toString
    return "{x: $x, y: $y, h: $h}";
  }

  Map<String, int> toFirestoreObj(){
    return {
      "x": x.toInt(),
      "y": y.toInt(),
      "h": h.toInt()
    };
  }
}