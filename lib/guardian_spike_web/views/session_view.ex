defmodule GuardianSpikeWeb.SessionView do
  use GuardianSpikeWeb, :view
  alias GuardianSpikeWeb.SessionView

  def render("login.json", %{user: user, token: token}) do
    %{ data: %{ token: token } }
  end
end
