defmodule TraderX.MathTest do
  use ExUnit.Case

  alias TraderX.Formulas

  describe "stability/1" do
    assert 0.5 == Formulas.stability(100, 50)
    assert 0 == Formulas.stability(100, 0)
    assert 1 == Formulas.stability(100, 100)
    assert 0.2 == Formulas.stability(20, 100)
    assert 0.8 == Formulas.stability(100, 80)

    assert 0.01 == Formulas.stability(100, 1)
    assert 0.001 == Formulas.stability(1000, 1)
  end
end
