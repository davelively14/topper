defmodule Topper.Repo.Migrations.CreateReport do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :repair, :boolean, default: false
      add :topper, :boolean, default: false
      add :side, :string
      add :user_id, references(:users)
      add :intersection_id, references(:intersections)

      timestamps
    end
    create index(:reports, [:user_id])
    create index(:reports, [:intersection_id])

  end
end
