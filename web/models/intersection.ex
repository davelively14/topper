defmodule Topper.Intersection do
  use Topper.Web, :model

  schema "intersections" do
    belongs_to :sector, Topper.Sector
    belongs_to :street1, Topper.Street1
    belongs_to :street2, Topper.Street2

    timestamps
  end

  @required_fields ~w()
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
