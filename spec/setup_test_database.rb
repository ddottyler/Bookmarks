require 'pg'

p 'Setting up test database...'

connection = PG.connect(dbname: 'manager_bookmark_test')

connection.exec("TRUNCATE bookmarks;")