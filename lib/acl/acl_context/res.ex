defmodule Acl.Acl_context.Res do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :integer, autogenerate: false}
  schema "acl_res" do

    field :parent, :string, default: NULL
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
