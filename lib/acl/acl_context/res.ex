defmodule Acl.Acl_context.Res do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "acl_res" do

    field :parent, :string
    field :res, :string
    has_many :rules, Acl.Acl_context.Rule, foreign_key: :res_id
    timestamps()
  end

  @doc false
  def changeset(res, attrs) do
    res
    |> cast(attrs, [:res, :parent])
    |> validate_required([:res])
  end
end
