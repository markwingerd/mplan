class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def update_multiple
		#params = {"utf8"=>"✓", "_method"=>"put", "authenticity_token"=>"Ch3KLqHoaBwC9iYzomt8+/lLbjBbirwBWY3XUM5ATPEgcO5FqymkY1whgzypdv9/dJic0R+eqaeWsAsTe0wmjw==", :ingredient=>{:ingredient=>{"1"=>{"property_attributes"=>{"vegitarian"=>"1", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}, "2"=>{"property_attributes"=>{"vegitarian"=>"1", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}, "3"=>{"property_attributes"=>{"vegitarian"=>"0", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}, "4"=>{"property_attributes"=>{"vegitarian"=>"1", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"0"}, "buyInWholeUnits"=>"1"}, "5"=>{"property_attributes"=>{"vegitarian"=>"1", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}, "6"=>{"property_attributes"=>{"vegitarian"=>"0", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}, "7"=>{"property_attributes"=>{"vegitarian"=>"0", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"0"}, "8"=>{"property_attributes"=>{"vegitarian"=>"0", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}, "9"=>{"property_attributes"=>{"vegitarian"=>"0", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"0"}, "10"=>{"property_attributes"=>{"vegitarian"=>"0", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"0"}, "buyInWholeUnits"=>"1"}, "11"=>{"property_attributes"=>{"vegitarian"=>"1", "vegan"=>"0", "lactoseFree"=>"1", "glutenFree"=>"0"}, "buyInWholeUnits"=>"0"}, "12"=>{"property_attributes"=>{"vegitarian"=>"1", "vegan"=>"0", "lactoseFree"=>"0", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}, "13"=>{"property_attributes"=>{"vegitarian"=>"0", "vegan"=>"1", "lactoseFree"=>"1", "glutenFree"=>"1"}, "buyInWholeUnits"=>"1"}}}, "commit"=>"Submit", "controller"=>"ingredients", "action"=>"update_multiple"}
		#render plain: params[:ingredient][:ingredient]
		#test = params[:ingredient][:ingredient]
		# test["1"]["property_attributes"] = test["1"]["property"]
		# test["1"].delete("property")
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
		#render plain: params
		
		redirect_to :action => 'index'
	end

	def dfsfdsupdate_multiple
		params = {:buyInWholeUnits=>false,
				  :property_attributes=>
					{:vegitarian=>false, 
					 :vegan=>true, 
					 :lactoseFree=>true, 
					 :glutenFree=>true}
				 }

		ing = Ingredient.find(1)
		ing.update(params)

		#render plain: ing.buyInWholeUnits

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