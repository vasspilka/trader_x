defmodule TraderX.Data.OverviewStorage do
  use GenServer

  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(_initial_value) do
    GenServer.start_link(
      __MODULE__,
      %{
        remaining_symbols: TraderX.Symbols.get_all(),
        data: %{}
      },
      name: __MODULE__
    )
  end

  @impl true
  def init(state) do
    fetch_next()

    {:ok, state}
  end

  def get_state do
    :sys.get_state(__MODULE__)[:data]
  end

  def remaining do
    :sys.get_state(__MODULE__)[:remaining_symbols] |> Enum.count()
  end

  def get_overview(symbol) do
    GenServer.call(__MODULE__, {:get_symbol, symbol})
  end

  @impl true
  def handle_call({:get_symbol, symbol}, _from, state) do
    %{
      remaining_symbols: remaining_symbols,
      data: data
    } = state

    symbol_overview = data[symbol]

    if symbol_overview do
      {:reply, symbol_overview, state}
    else
      overview =
        TraderX.Data.BinnanceBroker.do_request(
          fn -> TraderX.Analytics.overview(symbol, "1d") end,
          1
        )

      new_state = %{
        remaining_symbols: List.delete(remaining_symbols, symbol),
        data: Map.put(data, symbol, overview)
      }

      {:reply, overview, new_state}
    end
  end

  @impl true
  def handle_info(
        :handle_next,
        %{
          remaining_symbols: [next | _remaining_symbols]
        } = state
      ) do
    {_, _, state} = handle_call({:get_symbol, next}, nil, state)
    fetch_next()

    {:noreply, state}
  end

  defp fetch_next() do
    Process.send(self(), :handle_next, [])
  end
end
