defmodule BlogWeb.Plugs.Session do
  @behaviour Plug
  import Plug.Conn, only: [get_req_header: 2, assign: 3]

  def init(_), do: nil

  def call(conn, _) do
    with ["Bearer secure_" <> token] <- get_req_header(conn, "authorization"),
         {id, ""} when id > 0 <- Integer.parse(token) do
      assign(conn, :user_id, id)
    else
      _ -> assign(conn, :user_id, nil)
    end
  end
end
