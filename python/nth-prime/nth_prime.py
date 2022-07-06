import math

def prime(number):
    if number == 0:
        raise ValueError('there is no zeroth prime')
    primes = [2]
    num = 3
    while len(primes) < number:
        if all(num % prime != 0 for prime in primes):
            primes.append(num)
        num += 1
    print(primes)
    return primes[-1]
