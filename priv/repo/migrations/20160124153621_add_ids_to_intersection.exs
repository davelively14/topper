defmodule Topper.Repo.Migrations.AddIdsToIntersection do
  use Ecto.Migration

  def change do
    add :street1_id, :integer
    add :street2_id, :integer

  end
end
