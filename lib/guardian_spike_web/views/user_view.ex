defmodule GuardianSpikeWeb.UserView do
  use GuardianSpikeWeb, :view
  alias GuardianSpikeWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      reference_id: user.reference_id,
      birthday: user.birthday,
      serial_number: user.serial_number}
  end
end
