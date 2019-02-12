defmodule Acl.Repo do
  use Ecto.Repo,
    otp_app: :acl,
    adapter: Ecto.Adapters.Postgres
end
