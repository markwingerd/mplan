class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def update_multiple
		ingredient_ids = params[:ingredient].keys
		@ingredients = Ingredient.find(ingredient_ids)
		@ingredients.each do |ingredient|
			ingredient.update_attributes!(:vegitarian => params[:ingredient][ingredient.id.to_s] )
		end
		render plain: params[:ingredient]["1"]
	end

end
