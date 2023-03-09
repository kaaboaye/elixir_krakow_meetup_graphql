defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :guid, :uuid, null: false
      add :title, :string
      add :content, :string

      timestamps()
    end

    create unique_index(:posts, [:guid])
  end
end
