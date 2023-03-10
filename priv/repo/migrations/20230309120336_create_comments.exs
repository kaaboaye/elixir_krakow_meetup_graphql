defmodule Blog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :guid, :uuid, null: false
      add :post_id, references(:posts, on_delete: :nothing), null: false

      add :author, :string
      add :content, :text

      timestamps()
    end

    create unique_index(:comments, [:guid])
    create index(:comments, [:post_id])
  end
end
