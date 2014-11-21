require 'rails_helper'

describe 'articles' do

	context 'no articles' do

		it 'should let the user know there are no posts' do
			visit '/articles'
			expect(page).to have_content("There are currently no articles")
		end

	end

	context 'with articles' do

		before do
			Article.create(title: "Charlie don't surf", text: "The story of the french in the Vietnam war")
		end

		it 'should list the posts' do
			visit '/articles'
			expect(page).to have_content("Charlie don't surf")
			expect(page).to have_content("The story of the french in the Vietnam war")
		end

	end

	context 'creating posts' do

		it 'adds the articles to a form' do
			visit '/articles'
			click_link('New article')
			fill_in 'article_title', with: 'Sparkling water: who really knows the story'
			fill_in 'article_text', with: 'At first sight'
			click_button('Save Article')

			expect(page).to have_content('Sparkling water: who really knows the story')
			expect(page).to have_content('At first sight')
			expect(current_path).to eq '/articles/1'
		end

		it 'does not add an invalid form' do
			visit '/articles'
			click_link('New article')
			fill_in 'article_title', with: 'Golf'
			fill_in 'article_text', with: 'So boring'
			click_button('Save Article')

			expect(page).to have_content('Title is too short (minimum is 5 characters)')
			expect(page).to have_content('Text is too short (minimum is 10 characters)')

			expect(current_path).to eq '/articles'
		end

	end


end
