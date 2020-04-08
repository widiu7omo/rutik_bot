require 'sequel'
Sequel.migration do
  up do
    create_table(:details) do
      primary_key :id
      foreign_key :project_id, :projects
      String :name
      String :status
    end
  end
  down do
    drop_table(:details)
  end
end