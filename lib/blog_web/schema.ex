defmodule BlogWeb.Schema do
  use Absinthe.Schema

  def context(ctx) do
    Map.put(ctx, :loader, BlogWeb.Dataloader.new())
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  import_types(Absinthe.Type.Custom)

  import_types(BlogWeb.Schema.Uuid)
  import_types(BlogWeb.Schema.Posts)
  import_types(BlogWeb.Schema.Comments)

  query do
    @desc "Health check"
    field :ping, non_null(:string) do
      resolve(fn _, _ -> {:ok, "pong"} end)
    end

    import_fields(:post_queries)
  end

  mutation do
    import_fields(:comment_mutations)
  end
end
