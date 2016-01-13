defmodule Topper.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :pass_hash, :string
      add :admin, :boolean, default: false

      timestamps
    end

  end
end
