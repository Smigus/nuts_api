defmodule NutsApi.Repo.Migrations.AddPostToComment do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :post_id, references(:posts)
    end
  end
end
