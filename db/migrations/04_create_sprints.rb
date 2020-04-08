require 'sequel'
Sequel.migration do
  up do
    create_table(:sprints) do
      primary_key :id
      foreign_key :detail_id, :details
      Date :start
      Date :deadline
      String :reward
    end
  end
  down do
    drop_table(:sprints)
  end
end