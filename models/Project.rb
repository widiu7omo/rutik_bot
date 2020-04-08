require 'sequel'
Sequel.connect('sqlite://rutik.db')
class Project < Sequel::Model
end