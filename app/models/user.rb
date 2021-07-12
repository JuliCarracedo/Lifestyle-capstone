class User < ApplicationRecord
    has_many :articles
    has_many :votes
    validate :name, uniqueness: true, length:{in: 2...20}, presence: true
end
