defmodule HelloPhoenix.LogActivityTest do
  use HelloPhoenix.ModelCase

  alias HelloPhoenix.LogActivity

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LogActivity.changeset(%LogActivity{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LogActivity.changeset(%LogActivity{}, @invalid_attrs)
    refute changeset.valid?
  end
end
