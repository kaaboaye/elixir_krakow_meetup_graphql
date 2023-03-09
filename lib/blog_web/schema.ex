defmodule BlogWeb.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers

  def context(ctx) do
    Map.put(ctx, :loader, BlogWeb.Dataloader.new())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  import_types(Absinthe.Type.Custom)

  object :post do
    field :id, non_null(:integer)
    field :guid, non_null(:string)
    field :title, non_null(:string)
    field :content, non_null(:string)

    field :comments, non_null(list_of(non_null(:comment))), resolve: dataloader(Blog.Repo)

    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  object :comment do
    field :id, non_null(:integer)
    field :guid, non_null(:string)
    field :author, non_null(:string)
    field :content, non_null(:string)
    field :inserted_at, non_null(:string)
    field :updated_at, non_null(:string)
  end

  query do
    @desc "Health check"
    field :ping, non_null(:string) do
      resolve(fn _, _ -> {:ok, "pong"} end)
    end

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
      arg(:guid, non_null(:string))

      resolve(fn %{guid: guid}, _ ->
        {:ok, Blog.Posts.get_post(guid)}
      end)
    end
  end

  input_object :add_comment_attrs do
    field :post_id, non_null(:integer)
    field :author, non_null(:string)
    field :content, non_null(:string)
  end

  mutation do
    field :add_comment, :comment do
      arg(:attrs, non_null(:add_comment_attrs))

      resolve(fn %{attrs: attrs}, _ ->
        Blog.Comments.create_comment(attrs)
      end)
    end
  end
end
