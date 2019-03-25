defmodule GuardianSpikeWeb.SessionControllerTest do
  use GuardianSpikeWeb.ConnCase

  alias GuardianSpike.Auth
  alias GuardianSpike.Auth.User
  alias GuardianSpike.Auth.Guardian

  test "login", %{conn: conn} do
    {:ok, user} = Auth.create_user(%{first_name: "Fred", last_name: "Person", email: "fred@person.com", password: "password"})
    response =
      post(conn, Routes.session_path(conn, :login), %{user: %{email: "fred@person.com", password: "password"}})
      |> json_response(200)
    assert %{ "data" => %{ "token" => token } } = response
    user_id = user.id
    assert {:ok, %{ id: user_id }, _stuff} = Guardian.resource_from_token(token)
  end
end
