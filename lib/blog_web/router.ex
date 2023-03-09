defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: BlogWeb.Schema

    forward "/gql", Absinthe.Plug, schema: BlogWeb.Schema
  end
end
