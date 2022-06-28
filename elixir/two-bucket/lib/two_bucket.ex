defmodule Bucket do
  defstruct capacity: 0, value: 0

  def new(capacity, value), do: %__MODULE__{capacity: capacity, value: value}

  def pour(b1, b2) do
    diff = min(b1.value, b2.capacity - b2.value)
    {%{b1 | value: b1.value - diff}, %{b2 | value: b2.value + diff}}
  end

  def fill(b), do: %{b | value: b.capacity}
  def empty(b), do: %{b | value: 0 }
end

defmodule TwoBucket do
  defstruct [:bucket_one, :bucket_two, :moves]
  @type t :: %TwoBucket{bucket_one: integer, bucket_two: integer, moves: integer}

  @doc """
  Find the quickest way to fill a bucket with some amount of water from two buckets of specific sizes.
  """
  @spec measure(
          size_one :: integer,
          size_two :: integer,
          goal :: integer,
          start_bucket :: :one | :two
        ) :: {:ok, TwoBucket.t()} | {:error, :impossible}
  def measure(size_one, size_two, goal, start_bucket) do
    {b1, b2} = case start_bucket do
      :one -> {Bucket.new(size_one, size_one), Bucket.new(size_two, 0)}
      :two -> {Bucket.new(size_one, 0), Bucket.new(size_two, size_two)}
    end
    queue = :queue.new()
    queue = :queue.in({b1, b2, 1}, queue)
    visited = MapSet.put(MapSet.new(), case start_bucket do
      :one -> {Bucket.new(size_one, 0), Bucket.new(size_two, size_two)}
      :two -> {Bucket.new(size_one, size_one), Bucket.new(size_two, 0)}
    end)
    bfs(queue, visited, goal)
  end

  defp bfs({[], []}, _, _), do: {:error, :impossible}
  defp bfs(queue, visited, target) do
    {{:value, {b1, b2, count}}, updated_queue} = :queue.out(queue)
    case {b1, b2, count} do
      {%Bucket{value: ^target}, _, _} -> {:ok, %TwoBucket{bucket_one: b1.value, bucket_two: b2.value, moves: count}}
      {_, %Bucket{value: ^target}, _} -> {:ok, %TwoBucket{bucket_one: b1.value, bucket_two: b2.value, moves: count}}
      _ ->
        cond do
          MapSet.member?(visited, {b1, b2}) -> bfs(updated_queue, visited, target)
          true ->
          updated_visited = MapSet.put(visited, {b1, b2})
          {from_b1, to_b2} = Bucket.pour(b1, b2)
          {from_b2, to_b1} = Bucket.pour(b2, b1)
          [
            {from_b1, to_b2},
            {to_b1, from_b2},
            {b1, Bucket.fill(b2)},
            {Bucket.empty(b1), b2},
            {b1, Bucket.empty(b2)},
            {Bucket.fill(b1), b2},
          ]
          |> Enum.map(fn {x, y} -> {x, y, count + 1} end)
          |> Enum.reduce(updated_queue, &:queue.in/2)
          |> bfs(updated_visited, target)

        end
    end
  end
end
