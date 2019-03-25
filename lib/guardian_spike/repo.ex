defmodule GuardianSpike.Repo do
  use Ecto.Repo,
    otp_app: :guardian_spike,
    adapter: Ecto.Adapters.Postgres
end
