defmodule Topper.IntersectionController do
  use Topper.Web, :controller

  alias Topper.Intersection

  plug :scrub_params, "intersection" when action in [:create, :update]

  def index(conn, _params) do
    intersections = Repo.all(Intersection)
    render(conn, "index.html", intersections: intersections)
  end

  def new(conn, _params) do
    changeset = Intersection.changeset(%Intersection{})
    streets = Repo.all(Topper.Street)
    street_sel = for street <- streets, do: {street.name, street.id}
    render(conn, "new.html", street_sel: street_sel, changeset: changeset)
  end

  def create(conn, %{"intersection" => intersection_params}) do
    changeset = Intersection.changeset(%Intersection{}, intersection_params)

    case Repo.insert(changeset) do
      {:ok, _intersection} ->
        conn
        |> put_flash(:info, "Intersection created successfully.")
        |> redirect(to: intersection_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    intersection = Repo.get!(Intersection, id)
    render(conn, "show.html", intersection: intersection)
  end

  def edit(conn, %{"id" => id}) do
    intersection = Repo.get!(Intersection, id)
    changeset = Intersection.changeset(intersection)
    render(conn, "edit.html", intersection: intersection, changeset: changeset)
  end

  def update(conn, %{"id" => id, "intersection" => intersection_params}) do
    intersection = Repo.get!(Intersection, id)
    changeset = Intersection.changeset(intersection, intersection_params)

    case Repo.update(changeset) do
      {:ok, intersection} ->
        conn
        |> put_flash(:info, "Intersection updated successfully.")
        |> redirect(to: intersection_path(conn, :show, intersection))
      {:error, changeset} ->
        render(conn, "edit.html", intersection: intersection, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    intersection = Repo.get!(Intersection, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(intersection)

    conn
    |> put_flash(:info, "Intersection deleted successfully.")
    |> redirect(to: intersection_path(conn, :index))
  end
end
