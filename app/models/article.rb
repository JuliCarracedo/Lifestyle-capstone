class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :votes
  validates :title, presence: true, length:{maximum: 30}
  validates :text, presence: true, length: {maximum: 200}

end
