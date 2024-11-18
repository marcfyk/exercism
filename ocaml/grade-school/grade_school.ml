open Base
module Int_map = Map.M (Int)

type school = string list Int_map.t

let empty_school = Map.empty (module Int)

let add student grade school =
  let f = function
    | None -> [ student ]
    | Some v -> (
        match List.find v ~f:(String.equal student) with
        | None -> student :: v
        | Some _ -> v)
  in
  Map.update school grade ~f

let grade grade school = Map.find school grade |> Option.value ~default:[]

let sorted school =
  let f ~key ~data results =
    Map.add_exn results ~key ~data:(List.sort data ~compare:String.compare)
  in
  Map.fold school ~init:empty_school ~f

let roster school =
  let f ~key:_ ~data results =
    List.sort data ~compare:String.compare @ results
  in
  Map.fold_right school ~init:[] ~f
