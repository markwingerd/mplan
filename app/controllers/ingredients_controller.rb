class IngredientsController < ApplicationController

	def index
		@ingredients = Ingredient.all
	end

	def new
		@ingredient = Ingredient.new
		if params["base_ingredient"]
			@base_ingredient = Ingredient.find_by(:name => params["base_ingredient"])
		else
			@base_ingredient = Ingredient.new
			@base_ingredient.property = Property.new
		end
	end

	def create
		if params['commit'] == "Use Base"
			redirect_to :action => 'new', :params => {base_ingredient: params[:ingredient][:name]}
		else
			@ingredient = Ingredient.new(ingredient_params)
			if @ingredient.save
				flash[:success] = 'Successfully created ingredient'
				redirect_to :action => 'index'
			else
				flash[:error] = 'Failed to create ingredient'
				render :action => 'new'
			end
		end
	end

	def autocomplete
		@ingredients = Ingredient.order(:name).where("name like ?", "%#{params[:term]}%")
		render json: @ingredients.map(&:name)
	end

	def update_multiple
		# Get ingredients from the database
		ingredient_ids = params[:ingredient][:ingredient].keys
		ingredients = Ingredient.find(ingredient_ids)
		ingredients.each do |ingredient|
			# Add property_id to params to allow rails to update the record rather than create a new one.
			params[:ingredient][:ingredient][ingredient.id.to_s][:property_attributes][:id] = ingredient.property.id
			ing_params = ingredient_params_by_id(ingredient.id)
			# Set vegitarian to true to vegan is true.
		 	if ing_params[:property_attributes][:vegan] == "1"
		 		ing_params[:property_attributes][:vegitarian] = true
		 	end
			ingredient.update_attributes!(ing_params)
		end	
		
		#render plain: JSON.pretty_generate(params)
		redirect_to :action => 'index'
	end

	private
		def ingredient_params
			params.require(:ingredient).permit(
				:name,
				:buyInWholeUnits,
				:property_attributes => [
					:id, 
					:vegitarian, 
					:vegan, 
					:lactoseFree, 
					:glutenFree ])
		end

		def ingredient_params_by_id(id)
			params.require(:ingredient).require(:ingredient).require(id.to_s).permit(
				:buyInWholeUnits,
				:property_attributes => [
					:id, 
					:vegitarian, 
					:vegan, 
					:lactoseFree, 
					:glutenFree ])
		end
end