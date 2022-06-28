package logs

type App struct {
	name   string
	symbol string
}

var recommendation App = App{name: "recommendation", symbol: "❗"}
var search App = App{name: "search", symbol: "🔍"}
var weather App = App{name: "weather", symbol: "☀"}

// Application identifies the application emitting the given log.
func Application(log string) string {
	for _, char := range log {
		switch string(char) {
		case recommendation.symbol:
			return recommendation.name
		case search.symbol:
			return search.name
		case weather.symbol:
			return weather.name
		}
	}
	return "default"
}

// Replace replaces all occurrences of old with new, returning the modified log
// to the caller.
func Replace(log string, oldRune, newRune rune) string {
	replacedLog := []rune(log)
	for index, value := range replacedLog {
		if value == oldRune {
			replacedLog[index] = newRune
		}
	}
	return string(replacedLog)
}

// WithinLimit determines whether or not the number of characters in log is
// within the limit.
func WithinLimit(log string, limit int) bool {
	return len([]rune(log)) <= limit
}
