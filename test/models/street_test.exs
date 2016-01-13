defmodule Topper.StreetTest do
  use Topper.ModelCase

  alias Topper.Street

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Street.changeset(%Street{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Street.changeset(%Street{}, @invalid_attrs)
    refute changeset.valid?
  end
end
