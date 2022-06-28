defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @newline "\n"
  @space " "
  @asterisk "*"
  @hashtag "#"

  @header_tag "h"
  @paragraph_tag "p"
  @bold_tag "strong"
  @italic_tag "em"
  @list_item_tag "li"
  @unordered_list_tag "ul"

  @bold_indicator "__"
  @italic_indicator "_"

  @spec parse(String.t()) :: String.t()
  def parse(data) do
    data
    |> String.split(@newline)
    |> Enum.map(&parse_line/1)
    |> Enum.join()
    |> parse_unordered_lists()
  end

  defp header?(text), do: text =~ ~r/^#{@hashtag}{1,6}[^#{@hashtag}]/
  defp list?(text), do: text =~ ~r/^[#{@asterisk}]/

  defp parse_line(text) do
    cond do
      header?(text) -> parse_header(text)
      list?(text) -> parse_list_md_level(text)
      true -> parse_paragraph_text(text)
    end
  end

  defp parse_header(text) do
    text
    |> parse_header_md_level()
    |> enclose_with_header_tag()
  end

  defp parse_header_md_level(text) do
    [h | t] = String.split(text)
    h = h |> String.length() |> to_string()
    t = t |> Enum.join(@space)
    {h, t}
  end

  defp parse_paragraph_text(text) do
    text
    |> String.split()
    |> join_words_with_tags()
    |> enclose_with_tag(@paragraph_tag)
  end

  defp parse_list_md_level(text) do
    text
    |> String.trim_leading(@asterisk)
    |> String.split()
    |> join_words_with_tags()
    |> enclose_with_tag(@list_item_tag)
  end

  defp open_tag(value), do: "<" <> value <> ">"
  defp close_tag(value), do: "</" <> value <> ">"
  defp enclose_with_tag(data, tag), do: open_tag(tag) <> data <> close_tag(tag)

  defp enclose_with_header_tag({level, data}), do: enclose_with_tag(data, "#{@header_tag}#{level}")

  defp join_words_with_tags(words) do
    words
    |> Stream.map(&replace_md_with_tag/1)
    |> Enum.join(@space)
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, open_tag(@bold_tag), global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, open_tag(@italic_tag), global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{@bold_indicator}{1}$/ -> String.replace(word, ~r/#{@bold_indicator}{1}$/, close_tag(@bold_tag))
      word =~ ~r/[^#{@italic_indicator}{1}]/ -> String.replace(word, ~r/#{@italic_indicator}{1}$/, close_tag(@italic_tag))
      true -> word
    end
  end

  defp parse_unordered_lists(text) do
    opening = open_tag(@unordered_list_tag) <> open_tag(@list_item_tag)
    closing = close_tag(@list_item_tag) <> close_tag(@unordered_list_tag)
    text
    |> String.replace(open_tag(@list_item_tag), opening, global: false)
    |> String.reverse()
    |> String.replace(String.reverse(close_tag(@list_item_tag)), String.reverse(closing), global: false)
    |> String.reverse()
  end
end
