defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}

  def build_tree([], []), do: {:ok, {}}
  def build_tree(preorder, inorder) do
    cond do
      Enum.count(preorder) != Enum.count(inorder) -> {:error, "traversals must have the same length"}
      preorder |> Enum.frequencies() |> Enum.any?(&elem(&1, 1) > 1) -> {:error, "traversals must contain unique items"}
      inorder |> Enum.frequencies() |> Enum.any?(&elem(&1, 1) > 1) -> {:error, "traversals must contain unique items"}
      true ->
        [root | preordertail] = preorder
        case Enum.split_while(inorder, &(&1 != root)) do
          {leftinorder, [^root | rightinorder]} ->
            {leftpreorder, rightpreorder} = Enum.split(preordertail, Enum.count(leftinorder))
            left = build_tree(leftpreorder, leftinorder)
            right = build_tree(rightpreorder, rightinorder)
            merge(left, root, right)
          _ -> {:error, "traversals must have the same elements"}
        end
    end
  end

  defp merge(left, root, right)
  defp merge({:error, _} = err, _, _), do: err
  defp merge(_, _, {:error, _} = err), do: err
  defp merge({:ok, left}, root, {:ok, right}), do: {:ok, {left, root, right}}
end
