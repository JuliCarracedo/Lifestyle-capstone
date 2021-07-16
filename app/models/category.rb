class Category < ApplicationRecord
    has_many :articles
    validates :name, length:{in: 2...15 },presence: true, uniqueness: true;

    def self.run_template
        create(name: "Entertainment", priority:2)
        create(name: "Tech", priority: 1)
        create(name: "Daily", priority: 3)
        create(name: "Politics", priority: 4)
        create(name: "Arts", priority: 6)
        create(name: "Sports", priority: 5)

    end 
end
