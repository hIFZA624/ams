defmodule Ams.Repo do
  use Ecto.Repo,
    otp_app: :ams,
    adapter: Ecto.Adapters.Postgres
end
