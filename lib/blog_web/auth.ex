defmodule BlogWeb.Auth do
  @behaviour Absinthe.Middleware

  def call(resolution, _opts) do
    case resolution.context do
      %{user_id: nil} ->
        Absinthe.Resolution.put_result(resolution, {:error, :unauthenticated})

      %{user_id: _user_id} ->
        resolution
    end
  end
end
