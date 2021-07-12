class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :votes
  validate: title, presence: true, length:{maximum: 30}
  validate: text, presence: true, length: {maximum: 200}
end
