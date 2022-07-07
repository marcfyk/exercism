/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let digits = get_digits(code);
    match digits {
        Err(_) => false,
        Ok(digits) =>
            digits
            .iter()
            .rev()
            .enumerate()
            .map(|(index, value)| if index % 2 == 1 { *value * 2 } else { *value })
            .map(|value| if value > 9 { value - 9 } else { value })
            .sum::<u32>() % 10 == 0
    }
}

fn get_digits(code: &str) -> Result<Vec<u32>, ()> {
    let parsed = code.chars()
        .filter(|c| *c != ' ')
        .map(|c| c.to_digit(10))
        .collect::<Vec<_>>();
    if parsed.iter().any(|d| d.is_none()) {
        return Err(())
    }
    let parsed = parsed
        .iter()
        .map(|d| d.unwrap())
        .collect::<Vec<_>>();
    match parsed.len() {
        0 | 1 => Err(()),
        _ => Ok(parsed)
    }
}
