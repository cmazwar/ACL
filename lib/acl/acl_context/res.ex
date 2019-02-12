defmodule Acl.Acl_context.Res do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:res, :string, autogenerate: false}
  schema "acl_res" do

    field :parent, :string, default: NULL
    #field :res, :string
    has_many :rules, Acl.Acl_context.Rule
    timestamps()
  end

  @doc false
  def changeset(res, attrs) do
    res
    |> cast(attrs, [:res, :parent])
    |> validate_required([:res])
  end
end
