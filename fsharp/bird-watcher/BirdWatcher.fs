module BirdWatcher

let lastWeek: int[] = [| 0; 2; 5; 3; 7; 8; 4 |]

let yesterday(counts: int[]): int = counts.[5]

let total(counts: int[]): int = Array.sum counts

let dayWithoutBirds(counts: int[]): bool = Array.exists (fun n -> n = 0) counts

let incrementTodaysCount(counts: int[]): int[] = Array.append counts.[0..5] [| 1 + counts.[6] |]

let oddWeek(counts: int[]): bool =
    match counts with
    | [| _; 0; _; 0; _; 0; _; |] -> true
    | [| _; 10; _; 10; _; 10; _; |] -> true
    | [| 5; _; 5; _; 5; _; 5; |] -> true
    | _ -> false
