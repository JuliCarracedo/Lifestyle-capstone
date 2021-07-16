require 'rails_helper'

RSpec.describe Article do
  before(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  before(:each) do
    User.create(name: 'Fisher')
    Category.create(name: 'Wealth')
  end

  describe 'creation' do
    it 'rejects the article if the title is missing' do
      article = Article.new(
        title: '', text: 'This is a good text',
        user_id: 1, category_id: 1
      )
      expect(article.save).to eq(false)
    end
    it 'rejects the article if the title is too long' do
      article = Article.new(
        title: 'This is the longest title I will ever write for a website of mine!', text: 'This is a good text',
        user_id: 1, category_id: 1
      )
      expect(article.save).to eq(false)
    end
    it 'rejects the article if user doesn\'t exist' do
      article = Article.new(
        title: 'This is a title', text: 'This is a good text',
        user_id: 2, category_id: 1
      )
      expect(article.save).to eq(false)
    end
    it 'rejects the article if category doesn\'t exist' do
      article = Article.new(
        title: 'This is a title', text: 'This is a good text',
        user_id: 1, category_id: 2
      )
      expect(article.save).to eq(false)
    end
  end
end
