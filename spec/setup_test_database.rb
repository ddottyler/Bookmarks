require 'pg'

def setup_test_database
  p 'Setting up test database...'

  connection = PG.connect(dbname: 'manager_bookmark_test')
  
  connection.exec("TRUNCATE bookmarks, comments, users;")
end