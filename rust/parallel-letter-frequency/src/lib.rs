use std::{collections::HashMap, thread, hash::Hash, cmp::min};

pub fn frequency(input: &[&str], worker_count: usize) -> HashMap<char, usize> {
    let actual_workload = min(worker_count, input.len());
    if actual_workload == 0 {
        return HashMap::new()
    }
    let workload = input.len() / actual_workload;
    input.chunks(workload)
        .map(|chunk| chunk.join("").to_lowercase())
        .map(|letters| thread::spawn(move || count_letters(letters)))
        .map(|t| t.join().unwrap())
        .fold(HashMap::new(), |acc, counts| merge_hashmap(acc, counts))
}

fn count_letters(letters: String) -> HashMap<char, usize> {
    letters.chars()
        .filter(|c| c.is_alphabetic())
        .fold(HashMap::new(), |mut acc, x| {
            let counter = acc.entry(x).or_insert(0);
            *counter += 1;
            acc
        })
}

fn merge_hashmap<T: Hash + Eq + Clone>(x: HashMap<T, usize>, y: HashMap<T, usize>) -> HashMap<T, usize> {
    y.iter()
        .fold(x, |mut acc, (k, v)| {
            let counter = acc.entry(k.clone()).or_insert(0);
            *counter += v;
            acc
        })
}


