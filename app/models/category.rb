class Category < ApplicationRecord
    has_many :articles
    validates :name, length:{in: 2...15 },presence: true
end
