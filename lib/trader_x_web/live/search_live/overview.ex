defmodule TraderXWeb.SearchLive.Overview do
  use TraderXWeb, :live_view

  import TraderXWeb.Components.AppComponents

  @fields %TraderX.Analytics.Overview{}
          |> Map.keys()
          |> Kernel.--([:__struct__, :symbol])

  @operators ["==", "<", ">"]

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:condition_type, "field_to_field")
      |> assign(form: to_form(%{}, as: :search))
      |> assign(:search_results, [])
      |> assign(:fields, @fields)
      |> assign(:operators, @operators)

    {:ok, socket}
  end

  @impl true
  def handle_event("search", params, socket) do
    search_results =
      params
      |> TraderX.Search.build_condition()
      |> TraderX.Search.apply_search()

    {:noreply, assign(socket, :search_results, search_results)}
  end

  @impl true
  def handle_event("update", params, socket) do
    socket =
      socket
      |> assign(:condition_type, params["condition_type"])

    {:noreply, socket}
  end

  def selected_type(form) do
    dbg(form)
  end
end
