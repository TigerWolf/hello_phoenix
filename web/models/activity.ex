defmodule HelloPhoenix.Activity do
  use HelloPhoenix.Web, :model

  schema "activities" do
    field :name, :string
    field :points, :integer

    belongs_to :event, HelloPhoenix.Event
    has_many :logs, HelloPhoenix.LogActivity #through: [:log_activities, :log]
    timestamps
  end

  @required_fields ~w(name points event_id)
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
