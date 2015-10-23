class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
    	t.string :name

 		# Lifestyles
    	t.boolean :vegitarian, :default => false
    	t.boolean :vegan, :default => false

    	# Allergens
    	t.boolean :lactoseFree, :default => true
    	t.boolean :glutenFree, :default => true

    	# Purchase properties
    	t.boolean :buyInWholeUnits, :default => true
    	
      t.timestamps null: false
    end
  end
end
