require 'bookmark'
require 'database_helpers'

describe Bookmark do

  let(:comment_class) { double(:comment_class) }

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
      persisted_data = persisted_data(table: "bookmarks", id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Youtube'
      expect(bookmark.url).to eq 'http://www.youtube.com'
  
    end
    it 'does not create a new bookmark if the URL is not valid' do 
      Bookmark.create(url: 'not a real bookmark', title: 'not a real bookmark')
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.delete' do 
    it 'deletes a bookmark' do 
      bookmark = Bookmark.create(url: 'http://www.geoguesser.com', title: "GeoGuesser")

      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0 
    end
  end

  describe '.update' do
    it 'updates the bookmark with the given data' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      updated_bookmark = Bookmark.update(id: bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Snakers Academy'
      expect(updated_bookmark.url).to eq 'http://www.snakersacademy.com'
    end
  end

  describe '.find' do
    it 'returns the requested bookmark object' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Makers Academy'
      expect(result.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '#comments' do
    it 'returns a list of comments on the bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      DatabaseConnection.query("INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', #{bookmark.id})")
  
      comment = bookmark.comments.first
  p comment 
      expect(comment.text).to eq 'Test comment'
    end
  end

  describe '#comments' do
    it 'calls .where on the Comment class' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)
  
      bookmark.comments(comment_class)
    end
  end 
end