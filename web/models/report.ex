defmodule Topper.Report do
  use Topper.Web, :model

  schema "reports" do
    field :repair, :boolean, default: false
    field :topper, :boolean, default: false
    field :side, :string
    belongs_to :user, Topper.User
    belongs_to :intersection, Topper.Intersection

    timestamps
  end

  @required_fields ~w(repair topper side)
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
