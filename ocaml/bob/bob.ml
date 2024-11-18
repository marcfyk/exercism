type response_type =
  | YellingQuestion
  | Question
  | Yelling
  | Silence
  | AnythingElse

let is_whitespace = function ' ' | '\t' | '\r' | '\n' -> true | _ -> false

let is_question s =
  let c =
    Seq.init (String.length s) (fun i -> String.get s (String.length s - i - 1))
    |> Seq.drop_while is_whitespace
    |> Seq.uncons
  in
  match c with None -> false | Some (hd, _) -> hd = '?'

let is_yelling s =
  let letters =
    String.to_seq s
    |> Seq.filter (function 'A' .. 'Z' | 'a' .. 'z' -> true | _ -> false)
  in
  if Seq.is_empty letters then false
  else Seq.for_all (function 'A' .. 'Z' -> true | _ -> false) letters

let is_silence = String.for_all is_whitespace

let parse_sentence s =
  let check_question = is_question s in
  let check_yelling = is_yelling s in
  let check_silence = is_silence s in
  if check_question && check_yelling then YellingQuestion
  else if check_question then Question
  else if check_yelling then Yelling
  else if check_silence then Silence
  else AnythingElse

let respond = function
  | YellingQuestion -> "Calm down, I know what I'm doing!"
  | Question -> "Sure."
  | Yelling -> "Whoa, chill out!"
  | Silence -> "Fine. Be that way!"
  | AnythingElse -> "Whatever."

let response_for s = respond @@ parse_sentence s
