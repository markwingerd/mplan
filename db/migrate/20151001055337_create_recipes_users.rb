class CreateRecipesUsers < ActiveRecord::Migration
  def change
    create_table :recipes_users do |t|
    	t.integer :recipe_id
    	t.integer :user_id
    	# I MAY NOT BE USING THIS
    end
  end
end
