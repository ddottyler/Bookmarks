require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'manager_bookmark_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES ('https://www.google.com')")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('https://www.twitter.com')")
      connection.exec("INSERT INTO bookmarks (url) VALUES ('https://www.bbc.com')")

      bookmarks = Bookmark.all

      expect(bookmarks).to include('https://www.google.com')
      expect(bookmarks).to include('https://www.twitter.com')
      expect(bookmarks).to include('https://www.bbc.com')
    end
  end
end