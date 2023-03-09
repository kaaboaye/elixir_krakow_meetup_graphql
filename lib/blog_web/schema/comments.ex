defmodule BlogWeb.Schema.Comments do
  use BlogWeb.Helpers

  object :comment do
    common_fields()

    field :author, non_null(:string)
    field :content, non_null(:string)
  end

  object :comment_queries do
    get_field(:get_comment, :comment, Blog.Comments, :get_comment)
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
