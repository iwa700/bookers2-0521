class AddNameToPostImages < ActiveRecord::Migration[6.1]
  def change
    add_column :post_images, :name, :shop_name
  end
end
