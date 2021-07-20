require 'rails_helper'

RSpec.describe Article do
  before(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  before(:each) do
    @user = User.create!(name: 'Fisher')
    @cat1 = Category.create!(name: 'Wealth')
    @cat2 = Category.create!(name: 'Marketing')
  end

  describe 'creation' do
    it 'rejects the article if the title is missing' do
      article = Article.new(
        title: '', text: 'This is a good text', user_id: 1
      )
      expect(article.save).to eq(false)
    end
    it 'rejects the article if the title is too long' do
      article = Article.new(
        title: 'This is the longest title I will ever write for a website of mine!',
        text: 'This is a good text', user_id: 1
      )
      expect(article.save).to eq(false)
    end
    it 'rejects the article if user doesn\'t exist' do
      article = Article.new(
        title: 'This is a title', text: 'This is a good text', user_id: 2
      )
      expect(article.save).to eq(false)
    end
    it 'rejects the article if category doesn\'t exist' do
      article = Article.new(
        title: 'This is a title', text: 'This is a good text', user_id: 1
      )
      expect(article.save).to eq(false)
    end
  end

  describe 'Category addition' do
    it 'assigns categories to an article via Categorization' do
      article = Article.create!(
        title: 'This is a title', text: 'This is a good text', user_id: @user.id
      )
      Categorization.create(article_id: article.id, category_id: @cat1.id)

      expect(article.categories.count).to eq(1)
    end

    it 'allows to include several categories simultaneously' do
      article = Article.create!(
        title: 'This is a title', text: 'This is a good text', user_id: @user.id
      )
      Categorization.create(article_id: article.id, category_id: @cat1.id)
      Categorization.create(article_id: article.id, category_id: @cat2.id)
      expect(article.categories.count).to eq(2)
    end

    it "doesn't allow for duplicate categorizations" do
      article = Article.create!(
        title: 'This is a title', text: 'This is a good text', user_id: @user.id
      )
      Categorization.create(article_id: article.id, category_id: @cat1.id)
      Categorization.create(article_id: article.id, category_id: @cat1.id)
      expect(article.categories.count).to eq(1)
    end
  end
end
