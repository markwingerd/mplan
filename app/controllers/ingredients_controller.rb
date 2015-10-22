class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def update_multiple
		ingredient_ids = params[:ingredient][:ingredient].keys
		@ingredients = Ingredient.find(ingredient_ids)
		@ingredients.each do |ingredient|
			ingredient.update_attributes!({
				:vegitarian => params[:ingredient][:ingredient][ingredient.id.to_s][:vegitarian],
				:vegan => params[:ingredient][:ingredient][ingredient.id.to_s][:vegan],
				:lactoseFree => params[:ingredient][:ingredient][ingredient.id.to_s][:lactoseFree],
				:glutenFree => params[:ingredient][:ingredient][ingredient.id.to_s][:glutenFree],
				:buyInWholeUnits => params[:ingredient][:ingredient][ingredient.id.to_s][:buyInWholeUnits],
				})
		end
		
		redirect_to :action => 'index'
	end

end