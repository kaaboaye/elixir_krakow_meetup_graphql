defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :guid, Ecto.UUID, autogenerate: true
    field :title, :string
    field :content, :string
    field :user_id, :integer
    has_many :comments, Blog.Comments.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:user_id, :title, :content])
    |> validate_required([:title, :content])
  end
end
