defmodule BlogWeb.Plugs.GraphqlContext do
  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _), do: Absinthe.Plug.put_options(conn, context: conn.assigns)
end
