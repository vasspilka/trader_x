defmodule TraderXWeb.Components.AppComponents do
  @moduledoc """
  TraderX App components.
  """
  use Phoenix.Component

  # alias Phoenix.LiveView.JS

  @doc ~S"""
  Renders an overview table.

  ## Examples

      <.analysis_overview data={@data}>
  """
  attr :data, :map, required: true

  def analysis_overview(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
        <div class="py-2 inline-block min-w-full sm:px-6 lg:px-8">
          <div class="overflow-hidden">
            <table class="min-w-full">
              <tbody>
                <tr class="border-b">
                  <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                    Symbol
                  </td>
                  <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                    <%= @data.symbol %>
                  </td>
                </tr>
                <tr class="border-b">
                  <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                    Max High
                  </th>
                  <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                    <%= @data.max_high %>
                  </td>
                </tr>
                <tr class="border-b">
                  <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                    Min Low
                  </th>
                  <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                    <%= @data.min_low %>
                  </td>
                </tr>
                <tr class="border-b">
                  <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                    Median
                  </th>
                  <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                    <%= @data.median %>
                  </td>
                </tr>
                <tr class="border-b">
                  <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                    Overall Stability
                  </th>
                  <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                    <%= @data.overall_stability %>
                  </td>
                </tr>
                <tr class="border-b">
                  <th scope="col" class="text-sm font-medium text-gray-900 px-6 py-4 text-left">
                    Open Close Stability
                  </th>
                  <td class="text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap">
                    <%= @data.open_close_stability %>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
