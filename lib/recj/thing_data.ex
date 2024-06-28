defmodule Recj.ThingData do
  use Ecto.Schema

  import Ecto.Changeset

  schema "thing_data" do
    field :t, :integer
    field :thing, :string
    field :a, :float
    field :b, :float
    field :c, :float
  end

  def changeset(thing_data, attrs) do
    thing_data
    |> cast(attrs, [:t, :thing, :a, :b, :c])
    |> validate_required([:t, :thing])
    |> validate_inclusion(:thing, ~w[one two])
  end
end
