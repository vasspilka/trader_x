defmodule TraderXWeb.ChartLive.Analyze do
  use TraderXWeb, :live_view

  import TraderXWeb.Components.AppComponents

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(form: to_form(%{}, as: :analysis))
      |> assign(:data, nil)
      |> assign(:symbols, TraderX.Symbols.get_all())

    {:ok, socket}
  end

  @impl true
  def handle_event("analyze", %{"symbol" => symbol, "period" => period}, socket) do
    data = TraderX.Analytics.overview(symbol, period)

    {:noreply, assign(socket, :data, data)}
  end
end
