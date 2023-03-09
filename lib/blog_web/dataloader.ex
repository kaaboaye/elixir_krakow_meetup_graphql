defmodule BlogWeb.Dataloader do
  def new do
    Dataloader.new()
    |> Dataloader.add_source(Blog.Repo, Dataloader.Ecto.new(Blog.Repo))
  end
end
