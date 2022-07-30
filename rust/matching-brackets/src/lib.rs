pub fn brackets_are_balanced(string: &str) -> bool {
    let (status, stack) = string.chars().fold((true, vec![]), |(status, mut stack), b| {
        match (status, stack.last()) {
            (false, _) => (false, stack),
            (true, _) if is_opening(&b) => {
                stack.push(b);
                (true, stack)
            },
            (true, None) if is_closing(&b) => (false, stack),
            (true, None) => (true, stack),
            (true, Some(opening)) if is_closing(&b) && is_matching(opening, &b) => {
                stack.pop();
                (true, stack)
            },
            (true, Some(_)) if is_closing(&b) => (false, stack),
            (true, Some(_)) => (true, stack),
        }
    });
    status && stack.is_empty()
}

fn is_opening(b: &char) -> bool {
    ['(', '[', '{'].contains(b)
}

fn is_closing(b: &char) -> bool {
    [')', ']', '}'].contains(b)
}

fn is_matching(opening: &char, closing: &char) -> bool {
    match (opening, closing) {
        ('(', ')') => true,
        ('[', ']') => true,
        ('{', '}') => true,
        _ => false,
    }
}
