class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
    	t.string :name

 		# Lifestyles
    	t.boolean :vegitarian, :default => false
    	t.boolean :vegan, :default => false

    	# Allergens
    	t.boolean :lactoseFree, :default => false
    	t.boolean :glutenFree, :default => false
    	t.boolean :peanutFree, :default => false
    	t.boolean :soyFree, :default => false

    	# Purchase properties
    	t.boolean :buyInWholeUnites, :default => false
    	
      t.timestamps null: false
    end
  end
end
