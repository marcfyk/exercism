type allergen =
  | Eggs
  | Peanuts
  | Shellfish
  | Strawberries
  | Tomatoes
  | Chocolate
  | Pollen
  | Cats

let allergen_exp = function
  | Eggs -> 0
  | Peanuts -> 1
  | Shellfish -> 2
  | Strawberries -> 3
  | Tomatoes -> 4
  | Chocolate -> 5
  | Pollen -> 6
  | Cats -> 7

let allergen_score allergen =
  let exp = allergen_exp allergen in
  let rec aux acc exp = if exp = 0 then acc else aux (2 * acc) (exp - 1) in
  aux 1 exp

let allergic_to score allergen = score land allergen_score allergen <> 0

let allergies score =
  let allergens =
    [
      Eggs; Peanuts; Shellfish; Strawberries; Tomatoes; Chocolate; Pollen; Cats;
    ]
  in
  List.fold_right
    (fun a acc -> if allergic_to score a then a :: acc else acc)
    allergens []
