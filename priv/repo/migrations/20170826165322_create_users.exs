defmodule NutsApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :emoji_profile_pic, :string

      timestamps()
    end

  end
end
