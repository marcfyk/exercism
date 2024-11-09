let square_of_sum n = 
  let range = List.init n (fun x -> x + 1) in 
  let sum = List.fold_left (+) 0 range in
  sum * sum;;


let sum_of_squares n = 
  List.init n (fun x -> let x = x + 1 in x * x)
  |> List.fold_left (+) 0


let difference_of_squares n = square_of_sum n - sum_of_squares n
