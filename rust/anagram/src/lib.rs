use std::collections::HashSet;
use std::collections::HashMap;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    let map = get_char_frequencies(word);
    let set: HashSet<&'a str> = possible_anagrams.iter()
        .filter(|w| w.to_lowercase() != word.to_lowercase())
        .filter(|w| get_char_frequencies(w) == map)
        .map(|w| *w)
        .collect();
    set
}

fn get_char_frequencies(word: &str) -> HashMap<char, u32> {
    let mut word_map = HashMap::new();
    for c in word.to_lowercase().chars() {
        let count = word_map.entry(c).or_insert(0);
        *count += 1;
    }
    word_map
}
