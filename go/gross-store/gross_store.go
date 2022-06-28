package gross

// Units stores the Gross Store unit measurements.
func Units() map[string]int {
	m := make(map[string]int)
	m["quarter_of_a_dozen"] = 3
	m["half_of_a_dozen"] = 6
	m["dozen"] = 12
	m["small_gross"] = 120
	m["gross"] = 144
	m["great_gross"] = 1728
	return m
}

// NewBill creates a new bill.
func NewBill() map[string]int {
	return make(map[string]int)
}

// AddItem adds an item to customer bill.
func AddItem(bill, units map[string]int, item, unit string) bool {
	if _, ok := units[unit]; ok {
		if _, ok := bill[item]; !ok {
			bill[item] = 0
		}
		bill[item] += units[unit]
		return true
	}
	return false
}

// RemoveItem removes an item from customer bill.
func RemoveItem(bill, units map[string]int, item, unit string) bool {
	if quantity, ok := bill[item]; !ok {
		return false
	} else if count, ok := units[unit]; !ok {
		return false
	} else if quantity < count {
		return false
	} else if quantity == count {
		delete(bill, item)
		return true
	} else {
		bill[item] -= count
		return true
	}
}

// GetItem returns the quantity of an item that the customer has in his/her bill.
func GetItem(bill map[string]int, item string) (int, bool) {
	if quantity, ok := bill[item]; ok {
		return quantity, true
	} else {
		return 0, false
	}
}
