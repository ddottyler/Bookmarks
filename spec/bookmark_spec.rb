require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns a list of bookmarks' do
      connection = PG.connect(dbname: 'manager_bookmark_test')

      bookmark = Bookmark.create(url: "http://www.google.com", title: "Google")
      Bookmark.create(url: "http://www.twitter.com", title: "twitter")
      Bookmark.create(url: "http://www.bbc.com", title: "BBC")

      bookmarks = Bookmark.all
     
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'http://www.google.com'
    end
  end

  describe '.create' do 
    it 'creates a new bookmark' do 
      bookmark = Bookmark.create(url: 'http://www.youtube.com', title: "Youtube")
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Youtube'
      expect(bookmark.url).to eq 'http://www.youtube.com'
  
    end
  end
end