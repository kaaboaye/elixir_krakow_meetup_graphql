defmodule BlogWeb.Helpers do
  defmacro __using__(_) do
    quote do
      use Absinthe.Schema.Notation
      import Absinthe.Resolution.Helpers, warn: false
      import BlogWeb.Helpers, warn: false
    end
  end

  defmacro ids do
    quote do
      field :id, non_null(:integer)
      field :guid, non_null(:uuid)
    end
  end
end
