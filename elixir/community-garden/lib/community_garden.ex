# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do

  defstruct [plots: [], id_counter: 0]

  def start(opts \\ []) do
    Agent.start(fn -> %CommunityGarden{} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state ->
      state
      |> Map.fetch!(:plots)
    end)
  end

  def register(pid, register_to) do
    pid
    |> Agent.get_and_update(fn state ->
      id = 1 + Map.fetch!(state, :id_counter)
      plot = %Plot{plot_id: id, registered_to: register_to}
      updated_state = state
      |> Map.update!(:id_counter, fn x -> x + 1 end)
      |> Map.update!(:plots, fn x -> [plot | x] end)
      {plot, updated_state}
    end)
  end

  def release(pid, plot_id) do
    pid
    |> Agent.get_and_update(fn state ->
      updated_state = state
      |> Map.update!(:plots, fn x ->
        x |> Enum.filter(fn plot ->
          Map.fetch!(plot, :plot_id) != plot_id
        end)
      end)
      {:ok, updated_state}
    end)
  end

  def get_registration(pid, plot_id) do
    plot = pid
    |> Agent.get(fn state -> state end)
    |> Map.fetch!(:plots)
    |> Enum.find(fn x -> Map.fetch!(x, :plot_id) == plot_id end)
    case plot do
      nil -> {:not_found, "plot is unregistered"}
      _ -> plot 
    end
    
  end
end
