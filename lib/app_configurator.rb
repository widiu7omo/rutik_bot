require './lib/db_connection'
class AppConfigurator
  def configure
    setup_database
  end
  def setup_database
    DBConnection.connecting
  end
end