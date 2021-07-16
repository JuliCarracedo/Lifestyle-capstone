require 'rails_helper'

RSpec.describe Category do
  it 'rejects the category if name is too long' do
    category = Category.new(name: 'Unlucky mishaps of life and happiness')
    expect(category.save).to eq(false)
  end
  it 'rejects the category if name is too short' do
    category = Category.new(name: 'U')
    expect(category.save).to eq(false)
  end
  it 'rejects the category if the name is already used' do
    Category.create(name: 'Arts')
    category = Category.new(name: 'Arts')
    expect(category.save).to eq(false)
  end
  it 'accepts the category given you are within those boundaries' do
    category = Category.new(name: 'Happiness')
    expect(category.save).to eq(true)
  end
end
