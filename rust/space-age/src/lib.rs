// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.

const YEARS_MERCURY: f64 = 0.2408467;
const YEARS_VENUS: f64 = 0.61519726;
const YEARS_EARTH: f64 = 1.0;
const YEARS_MARS: f64 = 1.8808158;
const YEARS_JUPITER: f64 = 11.862615;
const YEARS_SATURN: f64 = 29.447498;
const YEARS_URANUS: f64 = 84.016846;
const YEARS_NEPTUNE: f64 = 164.79132; 

const YEAR_IN_SECONDS: isize = 31557600;

#[derive(Debug)]
pub struct Duration(u64);

impl From<u64> for Duration { fn from(s: u64) -> Self { Duration(s) } }

pub trait Planet { fn years_during(d: &Duration) -> f64 { 0.0 } }

pub struct Mercury;
pub struct Venus;
pub struct Earth;
pub struct Mars;
pub struct Jupiter;
pub struct Saturn;
pub struct Uranus;
pub struct Neptune;

impl Planet for Mercury { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_MERCURY / (YEAR_IN_SECONDS as f64) } }
impl Planet for Venus { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_VENUS / (YEAR_IN_SECONDS as f64) } }
impl Planet for Earth { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_EARTH / (YEAR_IN_SECONDS as f64) } }
impl Planet for Mars { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_MARS / (YEAR_IN_SECONDS as f64) } }
impl Planet for Jupiter { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_JUPITER / (YEAR_IN_SECONDS as f64) } }
impl Planet for Saturn { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_SATURN / (YEAR_IN_SECONDS as f64) } }
impl Planet for Uranus { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_URANUS / (YEAR_IN_SECONDS as f64) } }
impl Planet for Neptune { fn years_during(d: &Duration) -> f64 { (d.0 as f64) / YEARS_NEPTUNE / (YEAR_IN_SECONDS as f64) } }
