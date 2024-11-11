let reverse_string s =
  let length = String.length s in
  String.init length (fun i -> String.get s (length - i - 1))
