defmodule BlogWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)

  query do
    @desc "Health check"
    field :ping, non_null(:string) do
      resolve(fn _, _ -> {:ok, "pong"} end)
    end
  end
end
