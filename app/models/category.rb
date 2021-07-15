class Category < ApplicationRecord
    has_many :articles
    validates :name, length:{in: 2...15 },presence: true, uniqueness: true;

    self def run_template
        create(name: "Entertainment", priority: 1)
        create(name: "Tech", priority: 2)
        create(name: "Daily", priority: 3)
        create(name: "Politics", priority: 4)
        create(name: "Art", priority: 5)
        create(name: "Sports", priority: 6)
    end 
end
