class AddBookIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :book_id, :integer, default: 0
  end
end
