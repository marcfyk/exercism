defmodule TopSecret do

  defp get_function_data(args) do
    case args do
      [{:when, _, sub_args} | _] -> get_function_data(sub_args)
      [{name, _, sub_args} | _] when is_list(sub_args) -> {name, sub_args}
      [{name, _, sub_args} | _] when is_atom(sub_args) -> {name, []}
    end
  end

  defp decode_fn(args) do
    {fn_name, fn_args} = get_function_data(args)
    fn_name
    |> to_string
    |> String.slice(0, length(fn_args))
  end

  def to_ast(string) do
    string |> Code.string_to_quoted!
  end

  def decode_secret_message_part(ast, acc) do
    case ast do
      {:defp, _, args} -> {ast, [decode_fn(args) | acc]}
      {:def, _, args} -> {ast, [decode_fn(args) | acc]}
      _ -> {ast, acc}
    end
  end

  def decode_secret_message(string) do
    {_, acc} = string
    |> to_ast
    |> Macro.prewalk([], &decode_secret_message_part/2)
    acc
    |> Enum.reverse
    |> Enum.join("")
  end
end
