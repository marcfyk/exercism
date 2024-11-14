let make_hashtbl w =
  let size = String.length w in
  let m = Hashtbl.create ~random:true size in
  let upsert acc c =
    let () =
      Hashtbl.find_opt acc c |> Option.value ~default:0 |> ( + ) 1
      |> Hashtbl.replace acc c
    in
    acc
  in
  String.fold_left upsert m w

let is_hashtbl_equal h1 h2 =
  if Hashtbl.length h1 <> Hashtbl.length h2 then false
  else
    let check_elem_equal k v acc =
      match Hashtbl.find_opt h2 k with
      | Some v' -> acc && v = v'
      | None -> false
    in
    Hashtbl.fold check_elem_equal h1 true

let normalize = String.map Char.lowercase_ascii

let anagrams target candidates =
  let normalized_target = normalize target in
  let target_hashtbl = make_hashtbl normalized_target in
  let append_if_equal candidate acc =
    let normalized_candidate = normalize candidate in
    if normalized_target = normalized_candidate then acc
    else
      let hashtbl = make_hashtbl normalized_candidate in
      if
        (not @@ String.equal normalized_target normalized_candidate)
        && is_hashtbl_equal target_hashtbl hashtbl
      then candidate :: acc
      else acc
  in
  List.fold_right append_if_equal candidates []
