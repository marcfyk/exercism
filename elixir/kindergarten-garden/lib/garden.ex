defmodule Garden do

  @students [
    :alice, :bob, :charlie, :david,
    :eve, :fred, :ginny, :harriet,
    :ileana, :joseph, :kincaid, :larry,
  ]


  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    sorted_student_names = student_names
    |> Enum.sort()
    plants_data = info_string
    |> plants()
    |> plants_padded_to_length(length(student_names))
    Stream.zip(sorted_student_names, plants_data)
    |> Enum.into(Map.new())
  end

  defp plants(info_string) do
    info_string
    |> String.split("\n")
    |> Stream.map(&String.graphemes/1)
    |> Stream.map(&get_plant_row/1)
    |> Stream.zip()
    |> Stream.chunk_every(2)
    |> Stream.map(&get_ordering/1)
  end

  defp plants_padded_to_length(plants, n) do
    pad_length = n - Enum.count(plants)
    |> max(0)
    pad = Stream.iterate({}, fn _ -> {} end)
    |> Stream.take(pad_length)
    Stream.concat(plants, pad)
  end

  defp get_plant_row(plant_string) do
    plant_string
    |> Stream.map(&get_plant/1)
  end

  defp get_plant("G"), do: :grass
  defp get_plant("C"), do: :clover
  defp get_plant("R"), do: :radishes
  defp get_plant("V"), do: :violets

  defp get_ordering([{a, c}, {b, d}]), do: {a, b, c, d}

end

Garden.info("VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV")
