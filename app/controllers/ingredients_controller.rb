class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def update_multiple
		render plain: params
	end

end
