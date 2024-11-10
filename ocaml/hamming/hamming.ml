type nucleotide = A | C | G | T

let hamming_distance left right =
  let rec aux d1 d2 result =
    match (d1, d2, result) with
    | _, _, Error _ -> result
    | [], [], _ -> result
    | [], _, Ok 0 -> Error "left strand must not be empty"
    | _, [], Ok 0 -> Error "right strand must not be empty"
    | [], _, _ -> Error "left and right strands must be of equal length"
    | _, [], _ -> Error "left and right strands must be of equal length"
    | x1 :: d1, x2 :: d2, Ok count ->
        let count = if x1 <> x2 then count + 1 else count in
        aux d1 d2 (Ok count)
  in
  aux left right (Ok 0)
