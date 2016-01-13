defmodule Topper.SectorTest do
  use Topper.ModelCase

  alias Topper.Sector

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sector.changeset(%Sector{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sector.changeset(%Sector{}, @invalid_attrs)
    refute changeset.valid?
  end
end
