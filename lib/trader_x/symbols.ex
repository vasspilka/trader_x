defmodule TraderX.Symbols do
  use Agent

  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(_initial_value) do
    {:ok, prices} = ExBinance.Spot.Public.ticker_prices()

    symbols = Enum.map(prices, & &1.symbol)

    Agent.start_link(fn -> symbols end, name: __MODULE__)
  end

  @spec get_all :: list(binary)
  def get_all do
    Agent.get(__MODULE__, & &1)
  end
end
