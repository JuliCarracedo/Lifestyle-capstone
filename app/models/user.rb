class User < ApplicationRecord
  has_many :articles
  has_many :votes
  validates :name, uniqueness: true, length: { in: 2...20 }
end
