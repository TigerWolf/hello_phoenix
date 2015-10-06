defmodule HelloPhoenix.LogActivity do
  use HelloPhoenix.Web, :model

  schema "log_activities" do
    belongs_to :activity, HelloPhoenix.Activity
    belongs_to :log, HelloPhoenix.Log

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
