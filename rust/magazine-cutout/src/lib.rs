// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

use std::collections::HashMap;

pub fn can_construct_note(magazine: &[&str], note: &[&str]) -> bool {
    let mut note_map = HashMap::new();
    for note in note {
        let count = note_map.entry(note.to_string()).or_insert(0);
        *count += 1;
    }
    for m in magazine {
        if let Some(count) = note_map.get_mut(&m.to_string()) {
            *count -= 1;
        }
    }
    note.iter().all(|n| *note_map.get(&n.to_string()).unwrap() <= 0)
}
