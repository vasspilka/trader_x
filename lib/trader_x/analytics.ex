defmodule TraderX.Analytics do
  use TypedStruct

  alias TraderX.Data
  alias TraderX.Formulas

  typedstruct module: Overview do
    field :symbol, binary()
    field :max_high, float()
    field :current_price, float()
    field :min_low, float()
    field :median, float()
    field :volatility, float()
    field :open_close_stability, float()
    field :overall_stability, float()
    field :candles_count, integer()
  end

  @doc "This function retuns a percentage of the stability of a symbol based on candles"
  def overview(symbol, period) do
    {:ok, candles} = Data.candles(symbol, period)

    current_price = candles |> Enum.at(-1) |> Map.get(:close)

    open_close_stability =
      candles
      |> Enum.map(&Formulas.stability(&1.high, &1.low))
      |> Statistics.mean()

    opens = Enum.map(candles, & &1.open)
    closes = Enum.map(candles, & &1.close)

    max_high = Enum.max(Enum.map(candles, & &1.high))
    min_low = Enum.min(Enum.map(candles, & &1.low))

    med_open = Statistics.median(opens)
    med_close = Statistics.median(closes)

    med_avg = Statistics.mean([med_open, med_close])

    high_and_low =
      Enum.reduce(candles, [], fn candle, acc ->
        [candle.high, candle.low | acc]
      end)

    overall_stability =
      candles
      |> Enum.map(fn candle ->
        avg = Statistics.mean([candle.open, candle.close])

        Formulas.stability(avg, med_avg)
      end)
      |> Statistics.mean()

    %__MODULE__.Overview{
      symbol: symbol,
      max_high: max_high,
      min_low: min_low,
      median: med_avg,
      current_price: current_price,
      volatility: Formulas.volatility(high_and_low),
      open_close_stability: open_close_stability,
      overall_stability: overall_stability,
      candles_count: Enum.count(candles)
    }
  end
end
