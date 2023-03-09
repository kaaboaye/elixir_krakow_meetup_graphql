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

  defmacro timestamps do
    quote do
      field :inserted_at, non_null(:naive_datetime)
      field :updated_at, non_null(:naive_datetime)
    end
  end

  defmacro common_fields do
    quote do
      ids()
      timestamps()
    end
  end
end
