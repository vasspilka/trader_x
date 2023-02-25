defmodule TraderX.Data do
  @candle_float_keys [
    :close,
    :high,
    :low,
    :open,
    :quote_asset_volume,
    :taker_buy_base_asset_volume,
    :taker_buy_quote_asset_volume,
    :volume
  ]

  def candles(pair, period) do
    with {:ok, candles} <- ExBinance.Spot.Public.klines(pair, period) do
      data =
        Enum.map(candles, fn candle ->
          candle
          |> Map.from_struct()
          |> Enum.map(fn {key, value} ->
            if Enum.member?(@candle_float_keys, key) do
              {key, String.to_float(value)}
            else
              {key, value}
            end
          end)
          |> Enum.into(%{})
        end)

      {:ok, data}
    end
  end

  def get_all_candles() do
    TraderX.Symbols.get_all()
    |> Enum.map(fn symbol ->
      TraderX.Data.BinnanceBroker.do_request(fn -> candles(symbol, "1d") end, 1)
    end)
  end
end
