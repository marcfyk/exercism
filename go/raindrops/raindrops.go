package raindrops

import (
	"fmt"
	"strings"
)

func Convert(number int) string {
    output := make([]string, 0)
    if number % 3 == 0 {
        output = append(output, "Pling")
    }
    if number % 5 == 0 {
        output = append(output, "Plang")
    }
    if number % 7 == 0 {
        output = append(output, "Plong")
    }
    if len(output) == 0 {
        return fmt.Sprintf("%d", number)
    }
    return strings.Join(output, "")
}
