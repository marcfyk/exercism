pub fn build_proverb(list: &[&str]) -> String {
    match list {
        [] => "".to_string(),
        [x] => format!("And all for the want of a {x}."),
        _ => {
            let get_line = |s1: &str, s2: &str| -> String {
                format!("For want of a {s1} the {s2} was lost.")
            };
            let body = list.windows(2)
                .map(|chunk| (chunk[0], chunk[1]))
                .map(|(x, y)| get_line(x, y))
                .collect::<Vec<_>>()
                .join("\n");
            body + format!("\nAnd all for the want of a {}.", list[0]).as_str()
        }
    }
    
}


