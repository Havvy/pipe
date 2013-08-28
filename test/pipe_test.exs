defmodule PipeTest do
  use ExUnit.Case
  import Macros.Pipes

  def inc(n), do: n + 1
  def double(n), do: n * 2
  def square(n), do: n * n
  def mult(n, m), do: n * m

  "Favor |> over this form. It's here for completeness."
  test "sinple expression piping" do
    assert 6 = pipe([1, 2, 3], do: Enum.reduce(0, &(&1 + &2)))
  end

  test "block piping with single function" do
    six = pipe [1, 2, 3] do
      Enum.reduce(0, &(&1 + &2))
    end

    assert 6 = six
  end

  test "block piping with multiple functions" do
    four = pipe 1 do
      inc
      double
    end
    assert 4 = four
  end

  defpipe double_then_square(number) do
    double
    square
  end

  test "defpipe defines a function that is a pipe of its input argument" do
    assert 100 = double_then_square(5)
  end

  defpipe mult_n_by_m_then_double(n, m) do
    mult(m)
    double
  end

  test "defpipe with multiple arguments" do
    assert 84 = mult_n_by_m_then_double(6, 7)
  end
end
