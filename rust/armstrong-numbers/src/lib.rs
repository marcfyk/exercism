pub fn is_armstrong_number(num: u32) -> bool {
    let digits = get_digits(num);
    let length = digits.len();
    digits
        .into_iter()
        .map(|d| d.pow(length as u32))
        .sum::<u32>() == num
}

fn get_digits(num: u32) -> Vec<u32> {
    if num == 0 {
        return vec![0]
    }
    let mut n = num;
    let mut ds = vec![];
    while n != 0 {
        ds.push(n % 10);
        n /= 10;
    }
    ds
}
