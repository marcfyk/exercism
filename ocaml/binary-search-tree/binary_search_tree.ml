type bst = None | Node of int * bst * bst

let empty = None
let value = function None -> Error "" | Node (n, _, _) -> Ok n
let left = function None -> Error "" | Node (_, left, _) -> Ok left
let right = function None -> Error "" | Node (_, _, right) -> Ok right

let rec insert value = function
  | None -> Node (value, None, None)
  | Node (n, left, right) ->
      if value <= n then Node (n, insert value left, right)
      else Node (n, left, insert value right)

let to_list =
  let rec build_list acc = function
    | None -> acc
    | Node (n, left, right) -> build_list (n :: build_list acc right) left
  in
  build_list []
