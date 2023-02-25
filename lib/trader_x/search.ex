defmodule TraderX.Search do
  def load_overview() do
    TraderX.Symbols.get_all()
    |> Enum.map(fn symbol ->
      TraderX.Data.BinnanceBroker.do_request(
        fn -> TraderX.Analytics.overview(symbol, "1d") end,
        1
      )
    end)
  end

  def find_all_symbols(:stable_with_spikes) do
    load_overview()
    |> Enum.filter(fn overview ->
      overview.overall_stability > 80 &&
        overview.volatility > 60
    end)
  end
end
