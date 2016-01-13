defmodule Topper.IntersectionControllerTest do
  use Topper.ConnCase

  alias Topper.Intersection
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, intersection_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing intersections"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, intersection_path(conn, :new)
    assert html_response(conn, 200) =~ "New intersection"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, intersection_path(conn, :create), intersection: @valid_attrs
    assert redirected_to(conn) == intersection_path(conn, :index)
    assert Repo.get_by(Intersection, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, intersection_path(conn, :create), intersection: @invalid_attrs
    assert html_response(conn, 200) =~ "New intersection"
  end

  test "shows chosen resource", %{conn: conn} do
    intersection = Repo.insert! %Intersection{}
    conn = get conn, intersection_path(conn, :show, intersection)
    assert html_response(conn, 200) =~ "Show intersection"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, intersection_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    intersection = Repo.insert! %Intersection{}
    conn = get conn, intersection_path(conn, :edit, intersection)
    assert html_response(conn, 200) =~ "Edit intersection"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    intersection = Repo.insert! %Intersection{}
    conn = put conn, intersection_path(conn, :update, intersection), intersection: @valid_attrs
    assert redirected_to(conn) == intersection_path(conn, :show, intersection)
    assert Repo.get_by(Intersection, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    intersection = Repo.insert! %Intersection{}
    conn = put conn, intersection_path(conn, :update, intersection), intersection: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit intersection"
  end

  test "deletes chosen resource", %{conn: conn} do
    intersection = Repo.insert! %Intersection{}
    conn = delete conn, intersection_path(conn, :delete, intersection)
    assert redirected_to(conn) == intersection_path(conn, :index)
    refute Repo.get(Intersection, intersection.id)
  end
end
