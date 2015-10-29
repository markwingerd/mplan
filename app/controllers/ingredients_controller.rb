class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def update_multiple
		#render plain: JSON.pretty_generate(params)

		ingredient_ids = params[:ingredient][:ingredient].keys
		ingredients = Ingredient.find(ingredient_ids)
		ingredients.each do |ingredient|
			ing_params = ingredient_params(ingredient.id)
			if ing_params.has_key?(:property_attributes)
			 	if ing_params[:property_attributes][:vegan] == "1"
			 		ing_params[:property_attributes][:vegitarian] = true
			 	end
			end
			ingredient.update_attributes!(ing_params)
		end	
		
		redirect_to :action => 'index'
	end

	private

		def ingredient_params(id)
			params.require(:ingredient).require(:ingredient).require(id.to_s).permit(
				:buyInWholeUnits,
				:property_attributes => [
					:vegitarian, 
					:vegan, 
					:lactoseFree, 
					:glutenFree ])
		end
end