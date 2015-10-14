class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
    	t.decimal :amount
    	#t.boolean :needed, default: true #This is set to false only when the user already has the item.

    	t.belongs_to :recipe, index: true
    	t.belongs_to :user, index: true
    	t.belongs_to :ingredient, index: true

      t.timestamps null: false
    end
  end
end
