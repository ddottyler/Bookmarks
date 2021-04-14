feature 'Adding a new bookmark' do 
  scenario 'A user can add a bookmark to Bookmark Manager' do 
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.codewars.com')
    fill_in('title', with: 'CodeWars')
    click_button('Submit')

    expect(page).to have_content('http://www.codewars.com') 
  end
end