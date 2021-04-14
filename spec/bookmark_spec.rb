require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'manager_bookmark_test')

      Bookmark.create(url: "https://www.google.com")
      Bookmark.create(url: "https://www.twitter.com")
      Bookmark.create(url: "https://www.bbc.com")

      bookmarks = Bookmark.all

      expect(bookmarks).to include('https://www.google.com')
      expect(bookmarks).to include('https://www.twitter.com')
      expect(bookmarks).to include('https://www.bbc.com')
    end
  end

  describe '.create' do 
    it 'creates a new bookmark' do 
      Bookmark.create(url: 'http://www.youtube.com')

      expect(Bookmark.all).to include 'http://www.youtube.com'
    end
  end
end