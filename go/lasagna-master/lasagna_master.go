package lasagna

func PreparationTime(layers []string, n int) int {
	if n == 0 {
		n = 2
	}
	return n * len(layers)
}

func Quantities(layers []string) (noodles int, sauce float64) {
	for _, layer := range layers {
		if layer == "sauce" {
			sauce += 0.2
		} else if layer == "noodles" {
			noodles += 50
		}
	}
	return
}

func AddSecretIngredient(friendsList []string, myList []string) {
	myList[len(myList)-1] = friendsList[len(friendsList)-1]
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
	scaled := make([]float64, len(quantities))
	for index, value := range quantities {
		scaled[index] = value * float64(portions) / 2
	}
	return scaled
}
