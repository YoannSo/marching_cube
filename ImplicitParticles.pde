class ImplicitParticles {
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> dirs = new ArrayList<PVector>();

  ImplicitParticles() {
    for (int i = 0; i < N; i++) {
      points.add(new PVector(random(width), random(height)));
      dirs.add(PVector.random2D());
    }
  }

  void nextStep() {
    for (int i = 0; i < N; i++) {
      PVector p = points.get(i);
      PVector d = dirs.get(i);
      PVector dd = d.copy();
      dd.mult(vel);
      p.add(dd);
      if (p.x < 0) {
        p.x = 0; 
        d.x *= -1;
      }
      if (p.y < 0) {
        p.y = 0; 
        d.y *= -1;
      }
      if (p.x > width) {
        p.x = width; 
        d.x *= -1;
      }
      if (p.y > height) {
        p.y = height; 
        d.y *= -1;
      }
    }
  }

  void drawCircles() {
    for (PVector p : points) circle(p.x, p.y, radius*2);
  }

  float eval(float i, float j) {
    PVector n = new PVector(i, j);
    float v = 0;
    for (PVector p : points) v += f(p.dist(n)/radius);
    v += f((height-j)/radius);
    return v;
  }

  // 0 or 1
  int evalInt(float i, float j) {
    return (eval(i, j) >= 0.5) ? 1 : 0;
  }

  PVector interp(float x1, float y1, float x2, float y2) {
    return interpRec(x1, y1, x2, y2, REC_INTERP);
  }

  PVector interpRec(float x1, float y1, float x2, float y2, int level) {
    PVector p1 = new PVector(x1, y1);
    PVector p2 = new PVector(x2, y2);
    PVector m = PVector.lerp(p1, p2, 0.5);
    float v1 = evalInt(x1, y1);
    float v2 = evalInt(x2, y2);
    if ((level == 0) || (v1 == v2)) 
      return m;
    if (evalInt(m.x, m.y) == v1) return interpRec(m.x, m.y, x2, y2, level-1);
    return interpRec(x1, y1, m.x, m.y, level-1);
  }
}
