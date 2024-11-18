module CharSet = Set.Make (Char)

let is_pangram s =
  let a_to_z =
    List.init 26 (fun i -> char_of_int (i + int_of_char 'a')) |> CharSet.of_list
  in
  let subtract_from_set set c = CharSet.remove (Char.lowercase_ascii c) set in
  let result = String.fold_left subtract_from_set a_to_z s in
  CharSet.is_empty result
