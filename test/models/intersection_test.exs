defmodule Topper.IntersectionTest do
  use Topper.ModelCase

  alias Topper.Intersection

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Intersection.changeset(%Intersection{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Intersection.changeset(%Intersection{}, @invalid_attrs)
    refute changeset.valid?
  end
end
