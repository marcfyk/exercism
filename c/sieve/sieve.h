#ifndef SIEVE_H
#define SIEVE_H

#include <stddef.h>
#include <stdint.h>

/// Calculate at most `max_primes` prime numbers in the interval [2,limit]
/// using the Sieve of Eratosthenes and store the prime numbers in `primes`
/// in increasing order.
/// The function returns the number of calculated primes.
uint32_t sieve(const uint32_t limit, uint32_t *primes, const size_t max_primes);

#endif
