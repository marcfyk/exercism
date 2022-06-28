defmodule RPNCalculator do
  def calculate!(stack, operation) do
      stack |> operation.()
  end

  def calculate(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, calculate!(stack, operation)}
    rescue
      e in _ -> {:error, Map.fetch!(e, :message)}
    end
  end
end
