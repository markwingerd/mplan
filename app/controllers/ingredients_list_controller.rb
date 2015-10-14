class IngredientsListController < ApplicationController

  	before_filter :authenticate_user!

	def index
		@user = User.find(current_user.id)

		# Get a hash of all ingredient names for what a user has in stock.
		stocked_ingredients = {}
		for qty in @user.quantities do
			stocked_ingredients[qty.ingredient.name] = qty.amount
		end

		# Get a hash of all ingredient names for each recipe a user has queued.
		needed_ingredients = {}
		for recipe in @user.recipes do
		 	for qty in recipe.quantities do
		 		if needed_ingredients.keys.include?(qty.ingredient.name)
		 			needed_ingredients[qty.ingredient.name] += qty.amount
		 		else
					needed_ingredients[qty.ingredient.name] = qty.amount
				end
		 	end			
		end

		# Combine both hashes into a three dimentional list for the view. The 
		# outer list represents every unique ingredient a user may have. The
		# middle list represents a single ingredient and only ever contains
		# two lists, the first is needed ingredients (shopping list) obtained
		# from recipes, and the second is stocked ingredients. The innermost 
		# list represents a sort of key, value pair where the first is an
		# amount of an ingredient while the second is the name of the ingredient.
		@all_ingredients = []
		for ingredient in needed_ingredients.keys do
			if stocked_ingredients.keys.include?(ingredient)
				@all_ingredients << [ [needed_ingredients[ingredient], ingredient], [stocked_ingredients[ingredient], ingredient] ]
				stocked_ingredients.delete(ingredient)
			else
				@all_ingredients << [ [needed_ingredients[ingredient], ingredient], ["", ""] ] # No stocked ingredients
			end
		end
		# No more needed ingredients, fill the remaining stocked at the end
		# of the list.
		for ingredient in stocked_ingredients.keys do
			@all_ingredients << [ ["", ""], [stocked_ingredients[ingredient], ingredient] ]
		end
		
	end

	def show
	end

	def update
		@user = User.find(current_user)

		if @user.update(user_params)
		 	redirect_to :action => :index
		else
		 	render 'edit'
		end
	end

	private
		def user_params
			params.require(:user).permit(quantities_attributes: [:id, :amount, :ingredient_id, :_destroy])
		end

		def quantity_to_hash(qty)
			return {qty.ingredient.name => qty}
		end

end
