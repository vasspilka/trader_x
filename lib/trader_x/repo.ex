defmodule TraderX.Repo do
  use Ecto.Repo,
    otp_app: :trader_x,
    adapter: Ecto.Adapters.Postgres
end
