package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch card {
	case "ace":
		return 11
	case "king", "queen", "jack", "ten":
		return 10
	case "nine":
		return 9
	case "eight":
		return 8
	case "seven":
		return 7
	case "six":
		return 6
	case "five":
		return 5
	case "four":
		return 4
	case "three":
		return 3
	case "two":
		return 2
	case "one":
		return 1
	default:
		return 0
	}
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	c1 := ParseCard(card1)
	c2 := ParseCard(card2)
	sum := c1 + c2
	dealer := ParseCard(dealerCard)
	switch {
	case sum == 22:
		return "P"
	case sum == 21 && dealer < 10:
		return "W"
	case sum == 21:
		return "S"
	case 17 <= sum && sum <= 20:
		return "S"
	case 12 <= sum && sum <= 16 && dealer >= 7:
		return "H"
	case 12 <= sum && sum <= 16:
		return "S"
	default:
		return "H"
	}
}
