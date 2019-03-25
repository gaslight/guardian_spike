defmodule GuardianSpikeWeb.PageController do
  use GuardianSpikeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
