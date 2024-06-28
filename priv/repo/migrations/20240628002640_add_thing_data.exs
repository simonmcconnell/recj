defmodule Recj.Repo.Migrations.AddThingData do
  use Ecto.Migration

  def change do
    create table("thing_data") do
      add :t, :bigint, null: false
      add :thing, :text, null: false
      add :a, :float
      add :b, :float
      add :c, :float
    end

    create unique_index(:thing_data, [:t, :thing])
  end
end
