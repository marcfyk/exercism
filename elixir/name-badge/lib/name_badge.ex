defmodule NameBadge do
  def print(id, name, department) do
    department_value = if is_nil(department),
      do: "OWNER",
      else: department
    formatted_department = department_value |> String.upcase
    if is_nil(id),
      do: "#{name} - #{formatted_department}",
      else: "[#{id}] - #{name} - #{formatted_department}"
  end
end
