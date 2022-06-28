defmodule Username do
  def sanitize(''), do: ''
  def sanitize(username) do
    [head | tail] = username
    prefix =
      case head do
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        ?_ -> '_'
        c when ?a <= c and c <= ?z -> [c]
        _ -> ''
      end
    prefix ++ sanitize(tail)
  end
end
