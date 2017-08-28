defmodule NutsApi.Web.Router do
  use NutsApi.Web, :router

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

  scope "/", NutsApi.Web do
    pipe_through :api

    get "/posts", PostApiController, :index
    post "/like/:id", PostApiController, :like
    post "/unlike/:id", PostApiController, :unlike
    post "/comment/:id/:text", PostApiController, :add_comment
  end

  scope "/", NutsApi.Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", NutsApi.Web do
  #   pipe_through :api
  # end
end
