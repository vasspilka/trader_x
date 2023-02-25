defmodule TraderX.Search do
  def load_overview() do
    TraderX.Data.OverviewStorage.get_state()
    |> Enum.map(fn {key, value} ->
      %{value | symbol: key}
    end)

    # |> Map.values()
  end

  def find_all_symbols(:stable_with_spikes) do
    load_overview()
    |> Enum.filter(fn overview ->
      overview.overall_stability > 0.80 && overview.open_close_stability < 0.80
    end)
  end
end
