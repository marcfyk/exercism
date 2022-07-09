package hamming

import (
	"errors"
	"math"
)

func Distance(a, b string) (int, error) {
    if len(a) != len(b) {
        return 0, errors.New("invalid length")
    }
    count := 0
    index := 0
    for index < int(math.Min(float64(len(a)), float64(len(b)))) {
        if a[index] != b[index] {
            count += 1
        }
        index += 1
    }
    return count, nil
}
