require 'sequel'
Sequel.migration do
  up do
    create_table(:projects) do
      primary_key :id
      foreign_key :developer_id, :developers
      String :name
      String :github
    end
  end
  down do
    drop_table(:projects)
  end
end