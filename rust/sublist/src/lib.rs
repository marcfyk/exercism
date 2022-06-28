#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(_first_list: &[T], _second_list: &[T]) -> Comparison {
    let (x, y) = (_first_list.len(), _second_list.len());
    match (x, y) {
        (left, right) if left < right => {
            if x == 0 || _second_list.windows(x).any(|window| window == _first_list) {
                Comparison::Sublist
            } else {
                Comparison::Unequal
            }
        },
        (left, right) if left > right => {
            if y == 0 || _first_list.windows(y).any(|window| window == _second_list) {
                Comparison::Superlist
            } else {
                Comparison::Unequal
            }
        },
        (left, right) => {
            if _first_list == _second_list {
                Comparison::Equal
            } else {
                Comparison::Unequal
            }
        }
    }
}
