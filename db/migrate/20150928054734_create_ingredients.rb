class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
    	t.string :name

    	# Purchase properties
    	t.boolean :buyInWholeUnits, :default => true
    	
      t.timestamps null: false
    end
  end
end
