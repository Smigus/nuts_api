defmodule NutsApi.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias NutsApi.Content.Post


  @derive {Poison.Encoder, only: [:image_url, :num_likes, :user, :comments]}
  schema "posts" do
    field :image_url, :string
    field :num_likes, :integer
    belongs_to :user, NutsApi.Content.User
    has_many :comments, NutsApi.Content.Comment

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:image_url, :num_likes])
    |> validate_required([:image_url, :num_likes])
  end
end
