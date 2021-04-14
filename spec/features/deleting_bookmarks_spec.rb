feature 'Deleting a bookmark' do 
  scenario 'A user can delete a bookmark' do 
    Bookmark.create(url: 'http://www.espn.com', title: 'ESPN')
    visit('/bookmarks')
    expect(page).to have_link('ESPN', href: 'http://www.espn.com')
    first('.bookmark').click_button 'Delete'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('ESPN', href: 'http://www.espn.com')
  end
end