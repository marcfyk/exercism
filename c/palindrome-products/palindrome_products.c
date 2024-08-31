#include "palindrome_products.h"
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static int count_digits(int n) {
  int count = 0;
  do {
    ++count;
    n /= 10;
  } while (n > 0);
  return count;
}

static int count_leading_zeros(int n, int length) {
  int pad = pow(10, length - 1);
  int count = 0;
  while (pad > n) {
    pad /= 10;
    ++count;
  }
  return count;
}

static int count_trailing_zeros(int n) {
  if (n == 0) {
    return 1;
  }
  int count = 0;
  while (n > 0 && n % 10 == 0) {
    ++count;
    n /= 10;
  }
  return count;
}

static int reverse(int n) {
  int reversed = 0;
  do {
    reversed *= 10;
    reversed += n % 10;
    n /= 10;
  } while (n > 0);
  return reversed;
}

// verifies if n is a palindrome using int manipulation instead of
// allocating memory and comparing the string representation of n.
static bool is_palindrome(int n) {
  if (n < 0) {
    return false;
  }
  if (n < 10) {
    return true;
  }
  int digits = count_digits(n);
  int left, right;
  int exp = digits / 2;
  if (digits % 2 == 0) {
    int mask = pow(10, exp);
    left = n / mask;
    right = n % mask;
  } else {
    left = n / pow(10, exp + 1);
    right = n % (int)pow(10, exp);
  }
  int trailing = count_trailing_zeros(left);
  int leading = count_leading_zeros(right, exp);
  if (trailing != leading) {
    return false;
  }
  return reverse(left / pow(10, trailing)) == right;
}

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

product_t *get_palindrome_product(int from, int to) {
  product_t *p = malloc(sizeof(product_t));
  p->smallest = to * to + 1;
  p->largest = from * from - 1;
  p->factors_sm = NULL;
  p->factors_lg = NULL;
  if (from > to) {
    sprintf(p->error, "invalid input: min is %d and max is %d", from, to);
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
  if (p->smallest == to * to + 1) {
    sprintf(p->error, "no palindrome with factors in the range %d to %d", from,
            to);
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
  if (p->largest == from * from - 1) {
    sprintf(p->error, "no palindrome with factors in the range %d to %d", from,
            to);
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
