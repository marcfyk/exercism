module PizzaPricing

type Pizza =
    | Margherita
    | Caprese
    | Formaggio
    | ExtraSauce of Pizza
    | ExtraToppings of Pizza


let rec pizzaPriceTco (pizza: Pizza) (count: int): int =
    match pizza with
    | Margherita -> count + 7
    | Caprese -> count + 9
    | Formaggio -> count + 10
    | ExtraSauce p -> pizzaPriceTco p count + 1
    | ExtraToppings p -> pizzaPriceTco p count + 2

let rec pizzaPrice (pizza: Pizza): int = pizzaPriceTco pizza 0

let orderPrice(pizzas: Pizza list): int =
    pizzas
    |> List.map pizzaPrice
    |> List.sum
    |> fun total ->
        match pizzas.Length with
        | 1 -> 3 + total
        | 2 -> 2 + total
        | _ -> total

