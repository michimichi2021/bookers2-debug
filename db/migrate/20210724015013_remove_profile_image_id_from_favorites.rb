class RemoveProfileImageIdFromFavorites < ActiveRecord::Migration[5.2]
  def change
    remove_column :favorites, :profile_image_id, :integer
  end
end
