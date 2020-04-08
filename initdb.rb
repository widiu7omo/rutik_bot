require 'sequel'
require 'sqlite3'

DB = Sequel.connect('sqlite://rutik.db')
#create table if not exist
DB.create_table!(:developers) do
  primary_key :id
  String :name
  String :username
end
#create table if not exist
DB.create_table!(:projects) do
  primary_key :id
  foreign_key :developer_id, :developers
  String :name
  String :github
end
#create table if not exist
DB.create_table!(:details) do
  primary_key :id
  foreign_key :project_id, :projects
  String :name
  String :status
end
#create table if not exist
DB.create_table!(:sprint) do
  primary_key :id
  foreign_key :detail_id, :details
  Date :start
  Date :deadline
  String :reward
end
puts "projects table created"