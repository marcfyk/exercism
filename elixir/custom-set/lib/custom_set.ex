defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: %{}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    map = enumerable
    |> Stream.map(&{&1, nil})
    |> Enum.into(Map.new())
    %CustomSet{map: map}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set.map
    |> Enum.any?()
    |> Kernel.not()
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    custom_set.map
    |> Map.has_key?(element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.all?(&contains?(custom_set_2, &1))
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.any?(&contains?(custom_set_2, &1))
    |> Kernel.not()
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    custom_set_1 == custom_set_2
  end

  @spec add(t, any) :: t
  def add(custom_set, element) do
    %{custom_set | map: Map.put_new(custom_set.map, element, nil)}
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Stream.filter(&contains?(custom_set_2, &1))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Stream.filter(&(not contains?(custom_set_2, &1)))
    |> new()
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    Stream.concat(custom_set_1.map, custom_set_2.map)
    |> Stream.map(&elem(&1, 0))
    |> new()
  end
end
