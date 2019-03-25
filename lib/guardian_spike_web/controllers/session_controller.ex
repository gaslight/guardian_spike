defmodule GuardianSpikeWeb.SessionController do
  use GuardianSpikeWeb, :controller

  alias GuardianSpike.Auth
  alias GuardianSpike.Auth.Guardian

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    {:ok, user} = Auth.authenticate_user(email, password)
    {:ok, token, _stuff} = Guardian.encode_and_sign(user)
    render(conn, "login.json", %{ user: user, token: token })
  end
end
