defmodule Acl.Acl_context.Rule do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:action, :string, autogenerate: false, null: true, default: nil}
  @foreign_key_type :string
  schema "acl_rules" do
   # field :action, :string, primary_key: true
    field :allowed, :boolean, default: false
    field :permission, :string, primary_key: true, null: true, default: nil
    belongs_to :role_, Acl.Acl_context.Role, foreign_key: :role,  references: :role, primary_key: true
    belongs_to :res_, Acl.Acl_context.Res, foreign_key: :res,  references: :res, primary_key: true
    timestamps()
  end

  @doc false
  def changeset(rule, attrs) do
    rule
    |> cast(attrs, [:action, :permission, :allowed, :res, :role])
    |> validate_required([:res, :role])
  end
end
