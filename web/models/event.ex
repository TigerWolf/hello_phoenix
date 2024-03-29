defmodule HelloPhoenix.Event do
  use HelloPhoenix.Web, :model

  schema "events" do
    field :name, :string
    field :start_date, Ecto.DateTime
    field :end_date, Ecto.DateTime
    field :announcement, :string

    timestamps
  end

  @required_fields ~w(name start_date end_date)
  @optional_fields ~w(announcement)

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
