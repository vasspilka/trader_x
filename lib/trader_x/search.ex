defmodule TraderX.Search do
  use TypedStruct

  alias TraderX.Data.OverviewStorage

  typedstruct module: FieldToFieldCondition do
    field :field_a, binary()
    field :field_b, binary()
    field :operator, binary()
  end

  typedstruct module: FieldToValueCondition do
    field :field_a, binary()
    field :value, binary()
    field :operator, binary()
  end

  def build_condition(%{"field_a" => field_a, "operator" => operator, "field_b" => field_b}) do
    %FieldToFieldCondition{
      field_a: String.to_existing_atom(field_a),
      field_b: String.to_existing_atom(field_b),
      operator: operator
    }
  end

  def build_condition(%{"field_a" => field_a, "operator" => operator, "value" => value}) do
    %FieldToValueCondition{
      field_a: String.to_existing_atom(field_a),
      value: String.to_float(value),
      operator: operator
    }
  end

  def apply_search(%FieldToFieldCondition{
        field_a: field_a,
        field_b: field_b,
        operator: operator
      }) do
    operator_fn = String.to_existing_atom(operator)

    OverviewStorage.get_state()
    |> Enum.filter(fn {_symbol, overview} ->
      a = Map.get(overview, field_a)
      b = Map.get(overview, field_b)

      Kernel.apply(Kernel, operator_fn, [a, b])
    end)

    # |> Enum.into(%{})
  end

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
