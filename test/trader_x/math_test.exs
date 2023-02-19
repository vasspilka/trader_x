defmodule TraderX.MathTest do
  use ExUnit.Case

  alias TraderX.Formulas

  describe "stability/1" do
    Formulas.stability(100, 50)
    Formulas.stability(100, 0)
    Formulas.stability(100, 100)
    Formulas.stability(100, 50)
    Formulas.stability(100, 20)
    Formulas.stability(100, 80)
  end
end
