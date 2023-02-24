defmodule Geometry do
  # Write a function to compute the hypotenuse of a right triangle given the length of two sides.
  @spec hypotenuse({number, number}) :: float
  def hypotenuse({s1, s2}) do
    :math.sqrt(s1 ** 2 + s2 ** 2)
  end
end

defmodule AtomWrapper do
  # Convert a string to an atom.
  @spec string_to_atom(String.t()) :: atom
  def string_to_atom(s), do: String.to_atom(s)

  # Test to see if an expression is an atom.
  @spec is_an_atom(any) :: boolean
  def is_an_atom(x), do: is_atom(x)
end

# Given a list of numbers, use recursion to find (1) the size of the list, (2) the maximum value, and (3) the minimum value.
defmodule ListInfo do
  # recursive with 2 functions
  @spec info(list(integer)) :: {integer, integer | nil, integer | nil}
  def info([]), do: {0, nil, nil}

  def info([head | tail]) do
    {len, mx, mn} = info(tail)
    # || head because mx can be `nil`
    # as an atom, it sorts higher than all numbers, which doesn't work
    # min is fine, because the number is always smaller
    {len + 1, max(mx || head, head), min(mn, head)}
  end

  # recursive in a single function w/ `case`
  def info(l) do
    case l do
      [] ->
        {0, nil, nil}

      [head | tail] ->
        {len, mx, mn} = info(tail)
        {len + 1, max(mx || head, head), min(mn, head)}
    end
  end

  # also, non-recursive:
  # https://github.com/xavdid/seven-more-languages/blob/b49185006de2f84e83f5c363384c171c1b62619c/ch4_elixir/day_1/lib/day1.ex#L23-L28
end

# Given a list of atoms, build a function called word_count that returns a keyword list,
# where the keys are atoms from the list and the values are the number of
# occurrences of that word in the list.
# For example, word_count([:one, :two, :two]) returns [one: 1, two: 2].
defmodule WordCounter do
  @spec word_count(list(atom())) :: list({atom(), integer()})
  def word_count(l) do
    Enum.reduce(l, %{}, fn item, acc -> put_in(acc, [item], (acc[item] || 0) + 1) end)
    # |> Enum.map(& &1)
    |> Keyword.new()
  end
end
