pub fn square(s: u32) -> u64 {
    match s {
        _ if 1 <= s && s <= 64 => 2_u64.pow(s-1),
        _ => panic!("Square must be between 1 and 64"),
    }
}

pub fn total() -> u64 {
    u64::max_value()
}
