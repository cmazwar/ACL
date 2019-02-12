defmodule Acl.Repo.Migrations.CreateAclRes do
  use Ecto.Migration

  def change do
    create table(:acl_res, primary_key: false) do
      add :res, :string, null: false, primary_key: true, unique: true
      add :parent, :string, default: nil

      timestamps()
    end

  end
end
