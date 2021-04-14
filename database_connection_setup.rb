require './lib/database_connection.rb'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('manager_bookmark_test')
else
  DatabaseConnection.setup('manager_bookmark')
end