defmodule TraderX.Analysis do
  @doc "This function retuns a percentage of the stability of a symbol based on candles"
  def stability(candles) do
    open_close_stability =
      candles
      |> Enum.map(&difference_percentage(&1.open, &1.close))
      |> average()

    opens = Enum.map(candles, & &1.open)
    closes = Enum.map(candles, & &1.close)

    med_open = Statistics.median(opens)
    med_close = Statistics.median(closes)

    med_avg = average([Decimal.new(med_open), Decimal.new(med_close)])

    overall_stability =
      candles
      |> Enum.map(fn candle ->
        avg = average([Decimal.new(candle.open), Decimal.new(candle.close)])

        difference_percentage(avg, med_avg)
      end)
      |> average()

    %{
      open_close_stability: open_close_stability,
      overall_stability: overall_stability
    }
  end

  def average(decimals) do
    count = Enum.count(decimals)

    sum =
      Enum.reduce(decimals, Decimal.new(0), fn dec, acc ->
        Decimal.add(acc, dec)
      end)

    Decimal.div(sum, Decimal.new(count))
  end

  def difference_percentage(num1, num2) do
    [min, max] = Enum.sort([num1, num2])

    min = Decimal.new(min)
    max = Decimal.new(max)

    difference = Decimal.div(max, min)

    one = Decimal.sub(difference, 1)

    Decimal.sub(1, one)
  end
end
