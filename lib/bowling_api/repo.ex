defmodule BowlingApi.Repo do
  use Ecto.Repo,
    otp_app: :bowling_api,
    adapter: Ecto.Adapters.Postgres
end
