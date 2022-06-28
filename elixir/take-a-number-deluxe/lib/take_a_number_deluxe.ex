defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    min_n = Keyword.get(init_arg, :min_number)
    max_n = Keyword.get(init_arg, :max_number)
    timeout = Keyword.get(init_arg, :auto_shutdown_timeout, :infinity)
    cond do
      not is_number(min_n) -> {:error, :invalid_configuration}
      not is_number(max_n) -> {:error, :invalid_configuration}
      min_n > max_n -> {:error, :invalid_configuration}
      true -> GenServer.start_link(__MODULE__, init_arg, timeout: timeout)
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:queue_serve, priority_number: priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset)
  end

  # Server callbacks
  @impl GenServer
  def init(values) do
    min_n = Keyword.get(values, :min_number)
    max_n = Keyword.get(values, :max_number)
    timeout = Keyword.get(values, :auto_shutdown_timeout, :infinity)
    case TakeANumberDeluxe.State.new(min_n, max_n, timeout) do
      {:ok, state} -> {:ok, state, timeout}
      {:error, message} -> {:error, message, timeout}
    end
  end

  @impl GenServer
  def handle_call(:report, _, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new, _, state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} -> {:reply, {:ok, new_number}, new_state, state.auto_shutdown_timeout}
      err -> {:reply, err, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:queue_serve, priority_number: priority}, _, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority) do
      {:ok, number, new_state} -> {:reply, {:ok, number}, new_state, state.auto_shutdown_timeout}
      err -> {:reply, err, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset, state) do
    {_, reset_state} = TakeANumberDeluxe.State.new(
      state.min_number,
      state.max_number,
      state.auto_shutdown_timeout)
    {:noreply, reset_state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
