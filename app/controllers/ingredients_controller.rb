class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def update_multiple
		# Quick Fix: View uses a hash key of property but we need property_attributes.
		# 			 This manually changes the key.
		params[:ingredient][:ingredient].each do |k, v|
			params[:ingredient][:ingredient][k]["property_attributes"] = params[:ingredient][:ingredient][k]["property"]#.delete("property")
			params[:ingredient][:ingredient][k].delete("property")
		end

		ingredient_ids = params[:ingredient][:ingredient].keys
		ingredients = Ingredient.find(ingredient_ids)
		ingredients.each do |ingredient|
			ingredient_params = ingredient_params(ingredient.id)
		 	# if ingredient_params[:vegan] == "1"
		 	# 	ingredient_params[:vegitarian] = true
		 	# end
			ingredient.update_attributes!(ingredient_params)
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