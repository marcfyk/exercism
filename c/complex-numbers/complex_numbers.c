#include "complex_numbers.h"
#include <math.h>

complex_t c_add(const complex_t a, const complex_t b) {
  return (complex_t){.real = a.real + b.real, .imag = a.imag + b.imag};
}

complex_t c_sub(const complex_t a, const complex_t b) {
  return (complex_t){.real = a.real - b.real, .imag = a.imag - b.imag};
}

complex_t c_mul(const complex_t a, const complex_t b) {

  return (complex_t){.real = a.real * b.real - a.imag * b.imag,
                     .imag = a.imag * b.real + a.real * b.imag};
}

complex_t c_div(const complex_t a, const complex_t b) {
  return (complex_t){
      .real = (a.real * b.real + a.imag * b.imag) /
              (b.real * b.real + b.imag * b.imag),
      .imag = (a.imag * b.real - a.real * b.imag) /
              (b.real * b.real + b.imag * b.imag),
  };
}

double c_abs(const complex_t x) {
  return sqrt(pow(x.real, 2) + pow(x.imag, 2));
}

complex_t c_conjugate(const complex_t x) {
  return (complex_t){.real = x.real, .imag = -x.imag};
}

double c_real(const complex_t x) { return x.real; }

double c_imag(const complex_t x) { return x.imag; }

complex_t c_exp(const complex_t x) {
  const complex_t a = {.real = exp(x.real), .imag = 0};
  const complex_t b = {.real = cos(x.imag), .imag = sin(x.imag)};
  return c_mul(a, b);
}
