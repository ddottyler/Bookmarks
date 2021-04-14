require 'pg'

def persisted_data(id:)
  connection = PG.connect(dbname: 'manager_bookmark_test')
  connection.query("SELECT * FROM bookmarks WHERE id = '#{id}';")
end