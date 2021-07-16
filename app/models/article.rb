class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :votes
  validates :title, presence: true, length: { maximum: 30 }
  validates :text, presence: true, length: { maximum: 500 }

  def text_shortened
    if text.length > 60
      "#{text[0..57]}..."
    else
      text
    end
  end
end
