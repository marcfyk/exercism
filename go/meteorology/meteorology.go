package meteorology

import "fmt"

type TemperatureUnit int

const (
	Celsius    TemperatureUnit = 0
	Fahrenheit TemperatureUnit = 1
)

// Add a String method to the TemperatureUnit type
func (t *TemperatureUnit) String() string {
    if *t == Celsius {
        return "°C"
    } else if *t == Fahrenheit {
        return "°F"
    } else {
        return "UNKNOWN"
    }
}

type Temperature struct {
	degree int
	unit   TemperatureUnit
}

// Add a String method to the Temperature type
func (t *Temperature) String() string {
    return fmt.Sprintf("%d %s", t.degree, &t.unit)
}

type SpeedUnit int

const (
	KmPerHour    SpeedUnit = 0
	MilesPerHour SpeedUnit = 1
)

// Add a String method to SpeedUnit
func (t *SpeedUnit) String() string {
    if *t == KmPerHour {
        return "km/h"
    } else if *t == MilesPerHour {
        return "mph"
    } else {
        return "UNKNOWN"
    }

}

type Speed struct {
	magnitude int
	unit      SpeedUnit
}

// Add a String method to Speed
func (t *Speed) String() string {
    return fmt.Sprintf("%d %s", t.magnitude, &t.unit)
}

type MeteorologyData struct {
	location      string
	temperature   Temperature
	windDirection string
	windSpeed     Speed
	humidity      int
}

// Add a String method to MeteorologyData
func (t *MeteorologyData) String() string {
    return fmt.Sprintf(
        "%s: %s, Wind %s at %s, %d%% Humidity", 
        t.location, &t.temperature,
        t.windDirection, &t.windSpeed,
        t.humidity)
}
