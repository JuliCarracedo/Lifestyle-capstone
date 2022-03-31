class Categorization < ApplicationRecord
  belongs_to :article
  belongs_to :category
  validate :not_twice

  private

  def not_twice
    return if Categorization.find_by(article_id: article_id, category_id: category_id).nil?

    errors.add(:article, "can't join the same category twice")
  end
end
