// This stub file contains items that aren't used yet; feel free to remove this module attribute
// to enable stricter warnings.
#![allow(unused)]

pub fn production_rate_per_hour(speed: u8) -> f64 {
    let success_rate = if 1 <= speed && speed <= 4 {
        1.0
    } else if 5 <= speed && speed <= 8 {
        0.9
    } else if 9 <= speed && speed <= 10 {
        0.77
    } else {
        0.0
    };
    let production_rate = 221 as f64;
    success_rate * (speed as f64) * production_rate
}

pub fn working_items_per_minute(speed: u8) -> u32 {
    (production_rate_per_hour(speed) / (60 as f64)) as u32
}
