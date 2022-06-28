use time::PrimitiveDateTime as DateTime;
use time::Duration as DurationTime;

const GIGA_SECOND: i64 = 1_000_000_000;

// Returns a DateTime one billion seconds after start.
pub fn after(start: DateTime) -> DateTime {
    start.checked_add(DurationTime::new(GIGA_SECOND, 0)).unwrap()
}
