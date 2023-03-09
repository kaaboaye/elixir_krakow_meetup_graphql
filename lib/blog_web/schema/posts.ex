defmodule BlogWeb.Schema.Posts do
  use BlogWeb.Helpers

  object :post do
    ids()
    timestamps()

    field :title, non_null(:string)
    field :content, non_null(:string)

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
end
