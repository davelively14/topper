defmodule Topper.User do
  use Topper.Web, :model

  schema "users" do
    field :email, :string
    field :pass_hash, :string
    field :password, :string, virtual: true
    field :admin, :boolean, default: false

    timestamps
  end

  @required_fields ~w(email pass_hash admin)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
