type nucleotide = A | C | G | T

let hamming_distance d1 d2 =
  match (d1, d2) with
  | [], [] -> Ok 0
  | [], _ -> Error "left strand must not be empty"
  | _, [] -> Error "right strand must not be empty"
  | d1, d2 ->
      if List.length d1 <> List.length d2 then
        Error "left and right strands must be of equal length"
      else
        let count =
          List.combine d1 d2
          |> List.filter (fun (x1, x2) -> x1 <> x2)
          |> List.length
        in
        Ok count
