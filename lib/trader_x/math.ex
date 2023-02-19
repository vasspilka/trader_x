defmodule TraderX.Formulas do
  def stability(num1, num2) do
    [min, max] = Enum.sort([num1, num2])

    min / max
  end

  def volatility(floats) do
    Enum.reduce(floats, 0, fn float, acc ->
      acc + float - Enum.sum(floats) / Enum.count(floats)
    end)
  end
end
