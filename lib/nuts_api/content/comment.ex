defmodule NutsApi.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias NutsApi.Content.Comment


  @derive {Poison.Encoder, only: [:text]}
  schema "comments" do
    field :text, :string
    belongs_to :post, NutsApi.Content.Post

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:text])
    |> validate_required([:text])
  end
end
