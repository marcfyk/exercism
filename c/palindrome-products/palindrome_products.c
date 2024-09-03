#include "palindrome_products.h"
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int reverse_digits(int n) {
  int reversed = 0;
  while (n != 0) {
    reversed = reversed * 10 + n % 10;
    n /= 10;
  }
  return reversed;
}

// verifies if n is a palindrome using int manipulation instead of
// allocating memory and comparing the string representation of n.
static bool is_palindrome(int n) { return reverse_digits(n) == n; }

static factor_t *alloc_factor(int a, int b, factor_t *next) {
  factor_t *f = malloc(sizeof(factor_t));
  f->factor_a = a;
  f->factor_b = b;
  f->next = next;
  return f;
}

static factor_t *get_factors(int n, int from, int to) {
  factor_t *f = NULL;
  int x = from;
  int y = n / x;
  while (x <= sqrt(n)) {
    if (x > to || y > to) {
      y = n / ++x;
      continue;
    }
    if (x * y == n) {
      f = alloc_factor(x, y, f);
    }
    y = n / ++x;
  }
  return f;
}

static void errorInvalidInput(char *error, int from, int to) {
  sprintf(error, "invalid input: min is %d and max is %d", from, to);
}

static void errorNoPalindromeFound(char *error, int from, int to) {
  sprintf(error, "no palindrome with factors in the range %d to %d", from, to);
}

product_t *get_palindrome_product(int from, int to) {
  product_t *p = malloc(sizeof(product_t));
  const int max_value = to * to;
  const int min_value = from * from;
  p->smallest = max_value + 1;
  p->largest = min_value - 1;
  p->factors_sm = NULL;
  p->factors_lg = NULL;
  if (from > to) {
    errorInvalidInput(p->error, from, to);
    return p;
  }
  for (int i = from; i <= to; ++i) {
    for (int j = from; j <= to; ++j) {
      int candidate = i * j;
      if (candidate < p->smallest && is_palindrome(candidate)) {
        p->smallest = candidate;
      }
    }
  }
  if (p->smallest > max_value) {
    errorNoPalindromeFound(p->error, from, to);
    return p;
  }
  for (int i = to; i >= from; --i) {
    for (int j = to; j >= from; --j) {
      int candidate = i * j;
      if (candidate > p->largest && is_palindrome(candidate)) {
        p->largest = candidate;
      }
    }
  }
  if (p->largest < min_value) {
    errorNoPalindromeFound(p->error, from, to);
    return p;
  }
  p->factors_sm = get_factors(p->smallest, from, to);
  p->factors_lg = get_factors(p->largest, from, to);
  return p;
}

static void free_factors(factor_t *f) {
  factor_t *curr = f;
  factor_t *next;
  while (curr) {
    next = curr->next;
    free(curr);
    curr = next;
  }
}

void free_product(product_t *p) {
  if (p == NULL) {
    return;
  }
  free_factors(p->factors_sm);
  free_factors(p->factors_lg);
  free(p);
}
