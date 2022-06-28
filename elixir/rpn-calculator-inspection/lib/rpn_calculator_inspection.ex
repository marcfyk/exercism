defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> input |> calculator.() end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    trap_exit_state = Process.flag(:trap_exit, true)
    check = inputs
    |> Enum.map(fn input -> start_reliability_check(calculator, input) end)
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    Process.flag(:trap_exit, trap_exit_state)
    check
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input -> Task.async(fn -> input |> calculator.() end) end)
    |> Enum.map(fn task -> Task.await(task, 100) end)
  end
end
