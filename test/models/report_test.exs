defmodule Topper.ReportTest do
  use Topper.ModelCase

  alias Topper.Report

  @valid_attrs %{repair: true, side: "some content", topper: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Report.changeset(%Report{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Report.changeset(%Report{}, @invalid_attrs)
    refute changeset.valid?
  end
end
