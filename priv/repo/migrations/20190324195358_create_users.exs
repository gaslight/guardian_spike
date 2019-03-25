defmodule GuardianSpike.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :reference_id, :string
      add :birthday, :date
      add :serial_number, :string

      timestamps()
    end

  end
end
