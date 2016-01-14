defmodule Topper.User do
  use Topper.Web, :model

  schema "users" do
    field :email, :string
    field :pass_hash, :string
    field :password, :string, virtual: true
    field :admin, :boolean, default: false
    has_many :reports, Topper.Report

    timestamps
  end

  @required_fields ~w(email password admin)
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

  def reg_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> add_pass_hash()
  end

  defp add_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :pass_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
