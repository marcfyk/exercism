pub fn factors(n: u64) -> Vec<u64> {
    let mut divisors = 2..;
    let mut num = n;
    let mut factors = vec![];
    while num > 1 {
        let d = divisors.next().unwrap();
        while num % d == 0 {
            factors.push(d);
            num /= d;
        }
    }
    factors
}
