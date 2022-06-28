#[derive(Debug, Eq, PartialEq)]
pub struct Clock(i32);

const MINUTES_FROM_HOURS: i32 = 60;
const MINUTES_FROM_DAY: i32 = MINUTES_FROM_HOURS * 24;

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let mut value = (hours * MINUTES_FROM_HOURS + minutes) % MINUTES_FROM_DAY;
        while value < 0 {
            value = (value + MINUTES_FROM_DAY) % MINUTES_FROM_DAY;
        }
        Clock(value)
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        let mut value = (self.0 + minutes) % MINUTES_FROM_DAY;
        while value < 0 {
            value = (value + MINUTES_FROM_DAY) % MINUTES_FROM_DAY;
        }
        Clock(value)
    }
}

impl std::fmt::Display for Clock {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let hours = self.0 / MINUTES_FROM_HOURS;
        let minutes = self.0 - hours * MINUTES_FROM_HOURS;
        write!(f, "{:02}:{:02}", hours, minutes)
    }
}
