defmodule BlogWeb.Schema.Uuid do
  use Absinthe.Schema.Notation

  scalar :uuid, name: "UUID" do
    serialize(&encode/1)
    parse(&decode/1)
  end

  defp decode(%Absinthe.Blueprint.Input.String{value: value}), do: Ecto.UUID.cast(value)

  defp decode(%Absinthe.Blueprint.Input.Null{}), do: {:ok, nil}

  defp decode(_), do: :error

  defp encode(value), do: value
end
