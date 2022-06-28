defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    def exception(value) when is_bitstring(value), do: %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
    def exception(_), do: %StackUnderflowError{}
  end

  def divide([]), do: raise StackUnderflowError, "when dividing"
  def divide([_]), do: raise StackUnderflowError, "when dividing"
  def divide([0, _]), do: raise DivisionByZeroError
  def divide([x, y]), do: div(y, x)
  
end
