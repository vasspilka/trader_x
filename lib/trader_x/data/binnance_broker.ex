defmodule TraderX.Data.BinnanceBroker do
  use GenServer

  @initial_state %{weight: 1200}
  @refresh_time 60_000

  @spec start_link(any) :: {:error, any} | {:ok, pid}
  def start_link(_initial_value) do
    GenServer.start_link(__MODULE__, @initial_state, name: __MODULE__)
  end

  @impl true
  def init(stack) do
    refresh_weight()

    {:ok, stack}
  end

  def do_request(api_call, weight) do
    __MODULE__
    |> GenServer.call({:do_request, %{weight: weight, api_call: api_call}})
    |> case do
      {:ok, result} ->
        IO.inspect("Returning result")
        result

      {:error, :need_more_weight} ->
        IO.inspect("Need to wait more")
        Process.sleep(2000)

        do_request(api_call, weight)
    end
  end

  @impl true
  def handle_call({:do_request, %{weight: weight, api_call: api_call}}, _from, state) do
    new_weight = state.weight - weight

    if new_weight > 0 do
      response = {:ok, api_call.()}

      {:reply, response, %{weight: new_weight}}
    else
      response = {:error, :need_more_weight}

      {:reply, response, %{weight: weight}}
    end
  end

  @impl true
  def handle_info(:reset, _state) do
    IO.inspect("Resetting")
    refresh_weight()

    {:noreply, @initial_state}
  end

  defp refresh_weight() do
    Process.send_after(self(), :reset, @refresh_time)
  end
end
