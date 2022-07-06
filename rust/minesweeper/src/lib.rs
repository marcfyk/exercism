use std::ops::Range;

pub fn annotate(minefield: &[&str]) -> Vec<String> {
    minefield.iter().enumerate().map(|(i, row)| {
        row.chars().enumerate().map(|(j, c)| {
            match c {
                '*' => String::from("*"),
                _ => {
                    let count = bomb_count(minefield, (i, j));
                    match count {
                        0 => String::from(" "),
                        _ => count.to_string(),
                    }
                }

            }
        })
        .collect::<String>()
    })
    .collect()
}

fn valid_range(index: usize, limit: usize) -> Range<usize> {
    let lower_bound = if index <= 0 { 0 } else { index - 1 };
    let upper_bound = if index + 1 >= limit { index } else { index + 1 };
    lower_bound..upper_bound+1
}

fn adjacent_indexes(minefield: &[&str], (x, y): (usize, usize)) -> Vec<(usize, usize)> {
    valid_range(x, minefield.len())
        .map(|i| {
            valid_range(y, minefield[i].len())
                .map(|j| (i, j))
                .collect::<Vec<_>>()
        })
        .flatten()
        .collect()
}

fn bomb_count(minefield: &[&str], (x, y): (usize, usize)) -> usize {
    adjacent_indexes(minefield, (x, y))
        .iter()
        .map(|(i, j)| minefield[*i].chars().nth(*j).unwrap())
        .filter(|c| *c == '*')
        .count()
}
