type node = Node of int * node option * node option
type bst = node option

let empty = None
let value = function None -> Error "" | Some (Node (n, _, _)) -> Ok n
let left = function None -> Error "" | Some (Node (_, left, _)) -> Ok left
let right = function None -> Error "" | Some (Node (_, _, right)) -> Ok right

let rec insert value = function
  | None -> Some (Node (value, None, None))
  | Some (Node (n, left, right)) ->
      if value <= n then Some (Node (n, insert value left, right))
      else Some (Node (n, left, insert value right))

let rec to_list = function
  | None -> []
  | Some (Node (n, left, right)) -> to_list left @ (n :: to_list right)
