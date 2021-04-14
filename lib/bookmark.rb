require 'pg'

class Bookmark
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'manager_bookmark_test')
    else 
      connection = PG.connect(dbname: 'manager_bookmark')
    end
   result = connection.exec("SELECT * FROM bookmarks;")
   result.map { |bookmark| bookmark['url'] }
  end

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'manager_bookmark_test')
    else 
      connection = PG.connect(dbname: 'manager_bookmark')
    end
    
    connection.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")
  end
end