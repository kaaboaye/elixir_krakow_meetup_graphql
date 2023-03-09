defmodule BlogWeb.Schema.Posts do
  use BlogWeb.Helpers

  object :post do
    ids()
    timestamps()

    field :title, non_null(:string)
    field :content, non_null(:string)
    field :user_id, non_null(:integer)

    field :comments, non_null(list_of(non_null(:comment))), resolve: dataloader(Blog.Repo)
  end

  object :post_queries do
    field :list_posts, non_null(list_of(non_null(:post))) do
      resolve(fn _, _ ->
        {:ok, Blog.Posts.list_posts()}
      end)
    end

    get_field(:get_post, :post, Blog.Posts, :get_post)
  end

  input_object :add_post_attrs do
    field :title, non_null(:string)
    field :content, non_null(:string)
  end

  object :post_mutations do
    auth_field :add_post, :post do
      arg(:attrs, non_null(:add_post_attrs))

      resolve(fn %{attrs: attrs}, %{context: %{user_id: user_id}} ->
        attrs
        |> Map.put(:user_id, user_id)
        |> Blog.Posts.create_post()
      end)
    end
  end
end
