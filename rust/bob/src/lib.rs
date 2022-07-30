pub fn reply(message: &str) -> &str {
    let normalized = message.trim();
    let is_question = normalized.ends_with("?");
    let letters = normalized.chars().filter(|c| c.is_alphabetic()).collect::<String>();
    let is_yelling = !letters.is_empty() && letters.chars().all(|c| c.is_uppercase());
    if normalized.is_empty() {
        "Fine. Be that way!"
    } else if is_question && is_yelling {
        "Calm down, I know what I'm doing!"
    } else if is_question {
        "Sure."
    } else if is_yelling {
        "Whoa, chill out!"
    } else {
        "Whatever."
    }
}

