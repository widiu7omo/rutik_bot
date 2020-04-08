require 'sequel'

Sequel.migration do
  up do
    create_table(:developers) do
      primary_key :id
      String :name
      String :username
      String :github_account
    end
  end
  down do
    drop_table(:developers)
  end
end