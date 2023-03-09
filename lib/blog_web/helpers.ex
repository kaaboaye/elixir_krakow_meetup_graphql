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

      field :id_str, non_null(:string) do
        resolve(fn %{id: id}, _, _ ->
          {:ok, Integer.to_string(id)}
        end)
      end

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

  defmacro get_field(name, type, module, function) do
    id_name = :"#{name}_by_id"
    id_str_name = :"#{name}_by_id_str"
    uuid_name = :"#{name}_by_uuid"

    quote do
      field unquote(id_name), unquote(type) do
        arg(:id, non_null(:integer))

        resolve(fn %{id: id}, _ ->
          {:ok, unquote(module).unquote(function)(id)}
        end)
      end

      field unquote(id_str_name), unquote(type) do
        arg(:id_str, non_null(:string))

        resolve(fn %{id_str: id_str}, _ ->
          case Integer.parse(id_str) do
            {id, ""} -> {:ok, unquote(module).unquote(function)(id)}
            _ -> {:ok, nil}
          end
        end)
      end

      field unquote(uuid_name), unquote(type) do
        arg(:uuid, non_null(:uuid))

        resolve(fn %{uuid: uuid}, _ ->
          {:ok, unquote(module).unquote(function)(uuid)}
        end)
      end
    end
  end
end
