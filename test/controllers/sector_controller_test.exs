defmodule Topper.SectorControllerTest do
  use Topper.ConnCase

  alias Topper.Sector
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sector_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sectors"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, sector_path(conn, :new)
    assert html_response(conn, 200) =~ "New sector"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, sector_path(conn, :create), sector: @valid_attrs
    assert redirected_to(conn) == sector_path(conn, :index)
    assert Repo.get_by(Sector, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sector_path(conn, :create), sector: @invalid_attrs
    assert html_response(conn, 200) =~ "New sector"
  end

  test "shows chosen resource", %{conn: conn} do
    sector = Repo.insert! %Sector{}
    conn = get conn, sector_path(conn, :show, sector)
    assert html_response(conn, 200) =~ "Show sector"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, sector_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    sector = Repo.insert! %Sector{}
    conn = get conn, sector_path(conn, :edit, sector)
    assert html_response(conn, 200) =~ "Edit sector"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    sector = Repo.insert! %Sector{}
    conn = put conn, sector_path(conn, :update, sector), sector: @valid_attrs
    assert redirected_to(conn) == sector_path(conn, :show, sector)
    assert Repo.get_by(Sector, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sector = Repo.insert! %Sector{}
    conn = put conn, sector_path(conn, :update, sector), sector: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit sector"
  end

  test "deletes chosen resource", %{conn: conn} do
    sector = Repo.insert! %Sector{}
    conn = delete conn, sector_path(conn, :delete, sector)
    assert redirected_to(conn) == sector_path(conn, :index)
    refute Repo.get(Sector, sector.id)
  end
end
