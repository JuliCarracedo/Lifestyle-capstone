class RemoveColumnFromArticles < ActiveRecord::Migration[6.1]
  def change
    remove_reference :articles, :category, null: false, foreign_key: true
  end
end
