defmodule BlogWeb.Schema.Posts do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :post do
    field :id, non_null(:integer)
    field :guid, non_null(:uuid)
    field :title, non_null(:string)
    field :content, non_null(:string)

    field :comments, non_null(list_of(non_null(:comment))), resolve: dataloader(Blog.Repo)

    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  object :post_queries do
    field :list_posts, non_null(list_of(non_null(:post))) do
      resolve(fn _, _ ->
        {:ok, Blog.Posts.list_posts()}
      end)
    end

    field :get_post_by_id, :post do
      arg(:id, non_null(:integer))

      resolve(fn %{id: id}, _ ->
        {:ok, Blog.Posts.get_post(id)}
      end)
    end

    field :get_post_by_guid, :post do
      arg(:guid, non_null(:uuid))

      resolve(fn %{guid: guid}, _ ->
        {:ok, Blog.Posts.get_post(guid)}
      end)
    end
  end
end
