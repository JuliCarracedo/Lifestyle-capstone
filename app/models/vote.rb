class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  def self.most_voted_id
    find_by_sql(
      "SELECT article_id FROM votes
      GROUP BY article_id
      ORDER BY COUNT(user_id)
      DESC LIMIT 1"
    ).first.try(:article_id)
  end
end
