class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
    	t.string :name
      t.references :creator, index: true

      t.boolean :checkedByUser, :default => false
      t.boolean :checkedByAdmin, :default => false

    	# Purchase properties
    	t.boolean :buyInWholeUnits, :default => true
    	
      t.timestamps null: false
    end
  end
end
