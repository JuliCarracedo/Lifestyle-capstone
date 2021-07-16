require 'rails_helper'
RSpec.describe User do
  describe 'creation' do
    it 'rejects the user if name is too long' do
      user = User.new(name: 'Sir Maximus of Johannesburg, King of All lands')
      expect(user.save).to eq(false)
    end
    it 'rejects the user if name is too short' do
      user = User.new(name: 'S')
      expect(user.save).to eq(false)
    end
    it 'rejects the user if the username is already used' do
      User.create(name: 'John')
      user = User.new(name: 'John')
      expect(user.save).to eq(false)
    end
    it 'accepts the user given you are within those boundaries' do
      user = User.new(name: 'Walter')
      expect(user.save).to eq(true)
    end
  end
end
