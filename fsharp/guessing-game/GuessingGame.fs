module GuessingGame

let reply (guess: int): string =
    match guess with
    | 41 | 43 -> "So close"
    | _ when guess < 41 -> "Too low"
    | _ when guess > 43 -> "Too high"
    | _ -> "Correct"
