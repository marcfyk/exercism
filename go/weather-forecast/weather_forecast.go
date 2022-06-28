/*
Package weather forecasts the current weather condition
of various cities in Goblinocus.
*/
package weather

// CurrentCondition is the current weather condition.
var CurrentCondition string

// CurrentLocation is the current location to forecast.
var CurrentLocation string

/*
Forecast returns a formatted string for a given city
and with a weather condition.
*/
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
