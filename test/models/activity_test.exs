defmodule HelloPhoenix.ActivityTest do
  use HelloPhoenix.ModelCase

  alias HelloPhoenix.Activity

  @valid_attrs %{event_id: 42, name: "some content", points: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Activity.changeset(%Activity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Activity.changeset(%Activity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
