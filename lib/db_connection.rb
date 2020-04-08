require 'sequel'
require 'yaml'

class DBConnection
  class << self
    def connecting
      configuration = YAML::load(IO.read(database_config_path))
      Sequel.connect(configuration)
    end

    private

    def database_config_path
      'config/database.yml'
    end
  end
end