#include "square_root.h"

static const double epsilon = 1e-4;

double converge(const double x, const double n);

double converge(const double x, const double n) {
  const double f = (x * x) - n;
  const double f_prime = 2 * x;
  return f / f_prime;
}

double square_root(double n) {
  double root = n;
  double c;
  do {
    c = converge(root, n);
    root -= c;
  } while (c > epsilon);
  return root;
}
