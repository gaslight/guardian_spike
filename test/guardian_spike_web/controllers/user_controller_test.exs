defmodule GuardianSpikeWeb.UserControllerTest do
  use GuardianSpikeWeb.ConnCase

  alias GuardianSpike.Auth
  alias GuardianSpike.Auth.User

  @create_attrs %{
    birthday: ~D[2010-04-17],
    email: "some email",
    first_name: "some first_name",
    last_name: "some last_name",
    reference_id: "some reference_id",
    serial_number: "some serial_number"
  }
  @update_attrs %{
    birthday: ~D[2011-05-18],
    email: "some updated email",
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    reference_id: "some updated reference_id",
    serial_number: "some updated serial_number"
  }
  @invalid_attrs %{birthday: nil, email: nil, first_name: nil, last_name: nil, reference_id: nil, serial_number: nil}

  def fixture(:user) do
    {:ok, user} = Auth.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birthday" => "2010-04-17",
               "email" => "some email",
               "first_name" => "some first_name",
               "last_name" => "some last_name",
               "reference_id" => "some reference_id",
               "serial_number" => "some serial_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "birthday" => "2011-05-18",
               "email" => "some updated email",
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name",
               "reference_id" => "some updated reference_id",
               "serial_number" => "some updated serial_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
