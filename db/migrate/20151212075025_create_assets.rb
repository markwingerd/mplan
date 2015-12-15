class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
    	t.integer :recipe_id
    	t.has_attached_file :image
    	
      t.timestamps null: false
    end
  end
end
