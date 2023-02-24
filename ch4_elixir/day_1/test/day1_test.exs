defmodule Day1Test do
  use ExUnit.Case

  describe "Geometry" do
    test "functionality" do
      assert Geometry.hypotenuse({3, 4}) == 5
    end
  end

  describe "AtomWrapper" do
    test "functionality" do
      assert AtomWrapper.string_to_atom("asdf") == :asdf

      assert not AtomWrapper.is_an_atom("asdf")

      assert AtomWrapper.is_an_atom(:asdf)
    end
  end

  describe "ListInfo" do
    test "functionality" do
      assert ListInfo.info([]) == {0, nil, nil}
      assert ListInfo.info([1, 3, 5, 7, 9]) == {5, 9, 1}
      assert ListInfo.info([1, 3, -5, 7, 9]) == {5, 9, -5}
    end
  end

  describe "WordCounter" do
    test "functionality" do
      assert WordCounter.word_count([]) == []
      assert WordCounter.word_count([:one, :two, :one]) == [one: 2, two: 1]
    end
  end
end
