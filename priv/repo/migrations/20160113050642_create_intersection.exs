defmodule Topper.Repo.Migrations.CreateIntersection do
  use Ecto.Migration

  def change do
    create table(:intersections) do
      add :sector_id, references(:sectors)
      add :street1_id, references(:streets)
      add :street2_id, references(:streets)

      timestamps
    end
    create index(:intersections, [:sector_id])
    create index(:intersections, [:street1_id])
    create index(:intersections, [:street2_id])

  end
end
