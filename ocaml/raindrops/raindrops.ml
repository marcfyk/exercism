let raindrop n =
  let results =
    List.filter_map
      (fun (x, y) -> if n mod x = 0 then Some y else None)
      [ (3, "Pling"); (5, "Plang"); (7, "Plong") ]
  in
  match results with
  | [] -> string_of_int n
  | results -> String.concat "" results
