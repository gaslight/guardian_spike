defmodule GuardianSpikeWeb.Router do
  use GuardianSpikeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GuardianSpikeWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", GuardianSpikeWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]

    post "/login", SessionController, :login
  end
end
