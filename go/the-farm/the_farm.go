package thefarm

import (
	"errors"
	"fmt"
)

// See types.go for the types defined for this exercise.

// TODO: Define the SillyNephewError type here.
type SillyNephewError struct {
	Cows int
}

func (err SillyNephewError) Error() string {
	return fmt.Sprintf("silly nephew, there cannot be %v cows", err.Cows)
}

// DivideFood computes the fodder amount per cow for the given cows.
func DivideFood(weightFodder WeightFodder, cows int) (float64, error) {
	fodder, err := weightFodder.FodderAmount()
	if err == ErrScaleMalfunction {
		fodder *= 2
	} else if err != nil {
		return 0, err
	}

	switch {
	case fodder < 0:
		return 0, errors.New("negative fodder")
	case cows < 0:
		return 0, SillyNephewError{cows}
	case cows == 0:
		return 0, errors.New("division by zero")
	default:
		return fodder / float64(cows), nil
	}
}
