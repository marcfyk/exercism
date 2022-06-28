defmodule AllYourBase do

  defp base_to_num(list, base) do
    list
    |> Stream.zip(length(list)-1..0)
    |> Stream.map(fn {weight, exp} -> weight * base ** exp end)
    |> Enum.sum
  end

  defp num_to_base(num, base), do: num_to_base_acc(num, base, [])
  defp num_to_base_acc(0, _, []), do: [0]
  defp num_to_base_acc(0, _, list), do: list
  defp num_to_base_acc(num, base, list),
    do: num_to_base_acc(div(num, base), base, [rem(num, base) | list])



  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2,
    do: {:error, "input base must be >= 2"}
  def convert(digits, input_base, output_base) do
    cond do
      Enum.any?(digits, &(&1 < 0 or &1 >= input_base)) ->
        {:error, "all digits must be >= 0 and < input base"}
      true ->
        {:ok, digits |> base_to_num(input_base) |> num_to_base(output_base)}
    end
  end
end
