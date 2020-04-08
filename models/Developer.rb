require 'sequel'
Sequel.connect('sqlite://rutik.db')
class Developer < Sequel::Model
end