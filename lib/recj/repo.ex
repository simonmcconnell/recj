defmodule Recj.Repo do
  use Ecto.Repo,
    otp_app: :recj,
    adapter: Ecto.Adapters.Postgres
end
