class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
    	t.belongs_to :recipe, index: true
    	t.belongs_to :ingredient, index: true
    	
    	# Lifestyles
    	t.boolean :vegitarian, :default => false
    	t.boolean :vegan, :default => false

    	# Allergens
    	t.boolean :lactoseFree, :default => false
    	t.boolean :glutenFree, :default => false

      t.timestamps null: false
    end
  end
end
