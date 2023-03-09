defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug BlogWeb.Plugs.Session
  end

  pipeline :graphql do
    plug BlogWeb.Plugs.GraphqlContext
  end

  scope "/api" do
    pipe_through [:api, :graphql]

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: BlogWeb.Schema

    forward "/gql", Absinthe.Plug, schema: BlogWeb.Schema
  end
end
