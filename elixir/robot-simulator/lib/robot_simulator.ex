defmodule RobotSimulator do
  @type robot() :: any()
  @type direction() :: :north | :east | :south | :west
  @type position() :: {integer(), integer()}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0}) do
    %{direction: direction, position: position}
    |> validate_direction()
    |> validate_position()
  end

  defp validate_direction({:error, _} = err), do: err
  defp validate_direction(robot) do
    case robot.direction do
      :north -> robot
      :south -> robot
      :east -> robot
      :west -> robot
      _ -> {:error, "invalid direction"}
    end
  end

  defp validate_position({:error, _} = err), do: err
  defp validate_position(robot) do
    case robot.position do
      {x, y} when is_integer(x) and is_integer(y) -> robot
      _ -> {:error, "invalid position"}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Stream.map(&instruction/1)
    |> Enum.reduce(robot, fn
      _, {:error, _} = err -> err
      {:error, _} = err, _ -> err
      {:ok, f}, r -> f.(r)
    end)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot), do: robot.position

  defp turn({:error, _} = err, _), do: err
  defp turn(robot, :left) do
    case robot.direction do
      :north -> %{robot | direction: :west}
      :south -> %{robot | direction: :east}
      :east -> %{robot | direction: :north}
      :west -> %{robot | direction: :south}
    end
  end
  defp turn(robot, :right) do
    case robot.direction do
      :north -> %{robot | direction: :east}
      :south -> %{robot | direction: :west}
      :east -> %{robot | direction: :south}
      :west -> %{robot | direction: :north}
    end
  end

  defp advance({:error, _} = err), do: err
  defp advance( robot) do
    {x, y} = robot.position
    case robot.direction do
      :north -> %{robot | position: {x, y + 1}}
      :south -> %{robot | position: {x, y - 1}}
      :east -> %{robot | position: {x + 1, y}}
      :west -> %{robot | position: {x - 1, y}}
    end
  end

  defp instruction("A"), do: {:ok, &advance/1}
  defp instruction("L"), do: {:ok, &turn(&1, :left)}
  defp instruction("R"), do: {:ok, &turn(&1, :right)}
  defp instruction(_), do: {:error, "invalid instruction"}

end
