pub fn nth(n: u32) -> u32 {
    let mut primes = vec![2];
    let mut i = 3;
    while primes.len() <= (n as usize) {
        if !primes.iter().any(|p| i % p == 0) {
            primes.push(i);
        }
        i += 1;
    }
    *primes.last().unwrap()
}
