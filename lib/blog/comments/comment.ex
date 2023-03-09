defmodule Blog.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :guid, Ecto.UUID, autogenerate: true
    belongs_to :post, Blog.Posts.Post

    field :author, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:post_id, :author, :content])
    |> validate_required([:author, :content])
  end
end
