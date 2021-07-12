class Category < ApplicationRecord
    has_many :articles
    validate :name, length:{in: 2...15 },presence: true
end
