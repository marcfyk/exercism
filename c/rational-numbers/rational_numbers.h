#ifndef RATIONAL_NUMBERS_H
#define RATIONAL_NUMBERS_H

typedef struct {
  int numerator;
  int denominator;
} rational_t;

rational_t add(const rational_t r1, const rational_t r2);
rational_t subtract(const rational_t r1, const rational_t r2);
rational_t multiply(const rational_t r1, const rational_t r2);
rational_t divide(const rational_t r1, const rational_t r2);
rational_t absolute(const rational_t r);
rational_t exp_rational(const rational_t r, const int n);
float exp_real(const int n, const rational_t r);
rational_t reduce(const rational_t r);

#endif
