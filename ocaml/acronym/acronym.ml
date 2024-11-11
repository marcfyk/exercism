type state = InWord | InDelimiter | Stop

let is_delimiter c =
  Option.is_some @@ Array.find_opt (( = ) c) [| ' '; '_'; '-' |]

let should_stop c state =
  match state with
  | InWord -> if is_delimiter c then (false, InDelimiter) else (false, InWord)
  | InDelimiter -> if is_delimiter c then (false, InDelimiter) else (true, Stop)
  | Stop -> (true, Stop)

let cut s length index =
  if index >= length then None
  else
    let c = s.[index] in
    let rec aux s length i state =
      if i >= length then i
      else
        let stop, newState = should_stop s.[i] state in
        if stop then i else aux s length (i + 1) newState
    in
    let initial_state =
      if is_delimiter s.[index + 1] then InDelimiter else InWord
    in
    Some (Char.uppercase_ascii c, aux s length (index + 1) initial_state)

let acronym s =
  let length = String.length s in
  let rec aux acc i =
    if i >= length then acc
    else
      match cut s length i with
      | None -> acc
      | Some (c, index) ->
          let () = Buffer.add_char acc c in
          aux acc index
  in
  let buf = Buffer.create length in
  let buf = aux buf 0 in
  Buffer.contents buf
