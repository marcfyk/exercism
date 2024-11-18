module IntMap = Map.Make (Int)
module CharMap = Map.Make (Char)

let transform mappings =
  let int_map = mappings |> List.to_seq |> IntMap.of_seq in
  let char_map_builder point_value letters acc =
    let add_letters acc letter =
      CharMap.add (Char.lowercase_ascii letter) point_value acc
    in
    List.fold_left add_letters acc letters
  in
  let char_map = IntMap.fold char_map_builder int_map CharMap.empty in
  CharMap.to_list char_map
