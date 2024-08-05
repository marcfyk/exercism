#include "rational_numbers.h"
#include <math.h>
#include <stdlib.h>

int gcd(int a, int b);

int gcd(int a, int b) {
  while (b != 0) {
    a %= b;
    a ^= b;
    b ^= a;
    a ^= b;
  }
  return a;
}

rational_t add(const rational_t r1, const rational_t r2) {
  return reduce((rational_t){
      .numerator =
          r1.numerator * r2.denominator + r2.numerator * r1.denominator,
      .denominator = r1.denominator * r2.denominator,
  });
}

rational_t subtract(const rational_t r1, const rational_t r2) {
  return reduce((rational_t){
      .numerator =
          r1.numerator * r2.denominator - r2.numerator * r1.denominator,
      .denominator = r1.denominator * r2.denominator,
  });
}

rational_t multiply(const rational_t r1, const rational_t r2) {
  return reduce((rational_t){
      .numerator = r1.numerator * r2.numerator,
      .denominator = r1.denominator * r2.denominator,
  });
}

rational_t divide(const rational_t r1, const rational_t r2) {
  return reduce((rational_t){
      .numerator = r1.numerator * r2.denominator,
      .denominator = r2.numerator * r1.denominator,
  });
}

rational_t absolute(const rational_t r) {
  return reduce((rational_t){
      .numerator = abs(r.numerator),
      .denominator = abs(r.denominator),
  });
}

rational_t exp_rational(const rational_t r, const int n) {
  rational_t r1;
  if (n > 0) {
    r1.numerator = pow(r.numerator, n);
    r1.denominator = pow(r.denominator, n);
  } else {
    r1.numerator = pow(r.denominator, -n);
    r1.denominator = pow(r.numerator, -n);
  }
  return reduce(r1);
}

float exp_real(const int n, const rational_t r) {
  return pow(pow(n, r.numerator), 1 / (double)r.denominator);
}

rational_t reduce(const rational_t r) {
  int divisor = gcd(r.numerator, r.denominator);
  int n = r.numerator / divisor;
  int d = r.denominator / divisor;
  if (d < 0) {
    n = -n;
    d = -d;
  }
  return (rational_t){
      .numerator = n,
      .denominator = d,
  };
}
