defmodule NutsApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :image_url, :string
      add :num_likes, :integer

      timestamps()
    end

  end
end
