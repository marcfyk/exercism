open Base
module Int_map = Map.M (Int)

type school = string list Int_map.t

let empty_school = Map.empty (module Int)
let add student grade school = Map.add_multi ~key:grade ~data:student school
let grade grade school = Map.find_multi school grade
let sorted school = Map.map school ~f:(List.sort ~compare:String.compare)
let roster school = sorted school |> Map.data |> List.bind ~f:Fn.id
