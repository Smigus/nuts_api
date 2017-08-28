defmodule NutsApi.Content.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias NutsApi.Content.User


  @derive {Poison.Encoder, only: [:emoji_profile_pic, :name]}
  schema "users" do
    field :emoji_profile_pic, :string
    field :name, :string
    has_many :posts, NutsApi.Content.Post

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :emoji_profile_pic])
    |> validate_required([:name, :emoji_profile_pic])
  end
end
