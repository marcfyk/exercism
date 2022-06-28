defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new(), do: Map.new


  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    contains_name = Map.values(school) |> Enum.any?(&(MapSet.member?(&1, name)))
    cond do
      contains_name -> {:error, school}
      not contains_name -> {:ok, Map.update(school, grade, MapSet.new([name]), &(MapSet.put(&1, name)))}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    case Map.fetch(school, grade) do
      {:ok, names} -> names |> MapSet.to_list
      :error -> []
    end
    |> Enum.sort
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Map.keys
    |> Stream.map(&(grade(school, &1)))
    |> Enum.flat_map(&(&1))
  end
end
