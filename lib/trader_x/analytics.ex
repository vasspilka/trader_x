defmodule TraderX.Analytics do
  use TypedStruct

  alias TraderX.Data
  alias TraderX.Formulas

  typedstruct module: OverallAnalysis do
    field :max, Decimal.t()
    field :mix, Decimal.t()
    field :mean, Decimal.t()
    field :open_close_stability, Decimal.t()
    field :overall_stability, Decimal.t()
  end

  @doc "This function retuns a percentage of the stability of a symbol based on candles"
  def stability(pair, period) do
    {:ok, candles} = Data.candles(pair, period)

    open_close_stability =
      candles
      |> Enum.map(&Formulas.stability(&1.open, &1.close))
      |> Statistics.mean()

    opens = Enum.map(candles, & &1.open)
    closes = Enum.map(candles, & &1.close)

    med_open = Statistics.median(opens)
    med_close = Statistics.median(closes)

    med_avg = Statistics.mean([med_open, med_close])

    overall_stability =
      candles
      |> Enum.map(fn candle ->
        avg = Statistics.mean([candle.open, candle.close])

        Formulas.stability(avg, med_avg)
      end)
      |> Statistics.mean()

    %{
      open_close_stability: open_close_stability,
      overall_stability: overall_stability
    }
  end
end
