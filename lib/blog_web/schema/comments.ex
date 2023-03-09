defmodule BlogWeb.Schema.Comments do
  use BlogWeb.Helpers

  object :comment do
    ids()

    field :author, non_null(:string)
    field :content, non_null(:string)
    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  input_object :add_comment_attrs do
    field :post_id, non_null(:integer)
    field :author, non_null(:string)
    field :content, non_null(:string)
  end

  object :comment_mutations do
    field :add_comment, :comment do
      arg(:attrs, non_null(:add_comment_attrs))

      resolve(fn %{attrs: attrs}, _ ->
        Blog.Comments.create_comment(attrs)
      end)
    end
  end
end
