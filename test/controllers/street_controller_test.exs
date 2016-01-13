defmodule Topper.StreetControllerTest do
  use Topper.ConnCase

  alias Topper.Street
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, street_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing streets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, street_path(conn, :new)
    assert html_response(conn, 200) =~ "New street"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, street_path(conn, :create), street: @valid_attrs
    assert redirected_to(conn) == street_path(conn, :index)
    assert Repo.get_by(Street, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, street_path(conn, :create), street: @invalid_attrs
    assert html_response(conn, 200) =~ "New street"
  end

  test "shows chosen resource", %{conn: conn} do
    street = Repo.insert! %Street{}
    conn = get conn, street_path(conn, :show, street)
    assert html_response(conn, 200) =~ "Show street"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, street_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    street = Repo.insert! %Street{}
    conn = get conn, street_path(conn, :edit, street)
    assert html_response(conn, 200) =~ "Edit street"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    street = Repo.insert! %Street{}
    conn = put conn, street_path(conn, :update, street), street: @valid_attrs
    assert redirected_to(conn) == street_path(conn, :show, street)
    assert Repo.get_by(Street, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    street = Repo.insert! %Street{}
    conn = put conn, street_path(conn, :update, street), street: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit street"
  end

  test "deletes chosen resource", %{conn: conn} do
    street = Repo.insert! %Street{}
    conn = delete conn, street_path(conn, :delete, street)
    assert redirected_to(conn) == street_path(conn, :index)
    refute Repo.get(Street, street.id)
  end
end
