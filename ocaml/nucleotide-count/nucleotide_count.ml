open Base

let parse_nucleotide c =
  match c with 'A' | 'G' | 'C' | 'T' -> Ok c | _ -> Error c

let count_nucleotide s c =
  let nucleotide = parse_nucleotide c in
  Result.bind nucleotide ~f:(fun n ->
      let f acc c' =
        match acc with
        | Ok count ->
            let n' = parse_nucleotide c' in
            Result.map n' ~f:(fun n' ->
                if Char.equal n' n then count + 1 else count)
        | error -> error
      in
      String.fold s ~init:(Ok 0) ~f)

let count_nucleotides s =
  let f acc c =
    match acc with
    | Ok counts ->
        let n = parse_nucleotide c in
        Result.map n ~f:(fun n ->
            Map.update counts n ~f:(fun v -> 1 + Option.value v ~default:0))
    | error -> error
  in
  let map = Map.empty (module Char) in
  String.fold s ~init:(Ok map) ~f
