fn bottles(n: u32) -> String {
    match n {
        0 => "no more bottles".to_string(),
        1 => "1 bottle".to_string(),
        _ => format!("{} bottles", n),
    }
}

fn next_n(n: u32) -> u32 {
    match n {
        0 => 99,
        _ => n - 1,
    }
}

fn capitalize(s: &String) -> String {
    let mut chars = s.chars();
    match chars.next() {
        Some(c) => c.to_uppercase().to_string() + chars.as_str(),
        None => String::new(),
    }
}

fn first_line(n: u32) -> String {
    let current = bottles(n);
    format!("{} of beer on the wall, {} of beer.", capitalize(&current), current)
}

fn second_line(n: u32) -> String {
    let first_phrase = match n {
        0 => "Go to the store and buy some more",
        1 => "Take it down and pass it around",
        _ => "Take one down and pass it around"

    };
    format!("{}, {} of beer on the wall.", first_phrase, bottles(next_n(n)))
}

pub fn verse(n: u32) -> String {
    format!("{}\n{}\n", first_line(n), second_line(n))
}

pub fn sing(start: u32, end: u32) -> String {
    (end..start+1)
        .rev()
        .map(verse)
        .collect::<Vec<String>>()
        .join("\n")
}
