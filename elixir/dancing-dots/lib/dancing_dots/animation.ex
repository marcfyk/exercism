defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(o :: opts) :: {:ok, opts} | {:error, error}

  @callback handle_frame(d :: dot, f :: frame_number, o :: opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(o), do: {:ok, o}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(d, f, _) when rem(f, 4) == 0, do: Map.update!(d, :opacity, fn x -> x / 2 end)
  @impl DancingDots.Animation
  def handle_frame(d, _, _), do: d

end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(o) do
    v = o[:velocity]
    cond do
      is_number(v) -> {:ok, o}
      true -> {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(v)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(d, f, _) when f == 1, do: d

  @impl DancingDots.Animation
  def handle_frame(d, f, o) do
    v = o[:velocity]
    Map.update!(d, :radius, fn x -> x + (f - 1) * v end)
  end
end
