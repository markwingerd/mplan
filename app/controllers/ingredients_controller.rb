class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def update_multiple
		ingredient_ids = params[:ingredient][:ingredient].keys
		ingredients = Ingredient.find(ingredient_ids)
		ingredients.each do |ingredient|
			ingredient_params = ingredient_params(ingredient.id)
			if ingredient_params[:vegan] == "1"
				ingredient_params[:vegitarian] = true
			end
			ingredient.update_attributes!(ingredient_params)
		end	
		
		redirect_to :action => 'index'
	end

	private

		def ingredient_params(id)
			params.require(:ingredient).require(:ingredient).require(id.to_s).permit(
				:vegitarian, 
				:vegan, 
				:lactoseFree, 
				:glutenFree, 
				:buyInWholeUnits)
		end
end