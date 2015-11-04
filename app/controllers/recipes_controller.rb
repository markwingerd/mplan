class RecipesController < ApplicationController

	def index
	 	query = params[:query]
	 	command_hash = {}

		search = Recipe.search do
			fulltext query do
				boost_fields :title => 2.0
			end
		end
		@recipes = search.results
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
		@recipe.property = Property.new

		if @recipe.save
			@recipe.property.glutenFree = @recipe.ingredients.map {|ingredient| ingredient.property.glutenFree}.all?
			@recipe.property.lactoseFree = @recipe.ingredients.map {|ingredient| ingredient.property.lactoseFree}.all?
			@recipe.property.vegitarian = @recipe.ingredients.map {|ingredient| ingredient.property.vegitarian}.all?
			@recipe.property.vegan = @recipe.ingredients.map {|ingredient| ingredient.property.vegan}.all?

			if @recipe.property.save
				flash[:success] = 'Successfully created recipe'
				redirect_to @recipe
			else
				flash[:error] = 'Failed to create recipe/properties'
				render :action => 'new'
			end
		else
			flash[:error] = 'Failed to create recipe'
			render :action => 'new'
		end
	end

	def update
		@recipe = Recipe.find(params[:id])
		if (@recipe.update_attributes(recipe_params))
			redirect_to :action => 'show', :id => @recipe
		else
			render :action => 'edit'
		end
	end

	private
		def recipe_params
			params.require(:recipe).permit(:title, :description, :instructions, quantities_attributes: [:amount, :ingredient_id])
		end

		def get_recipe_properties(ingredients)
			return ingredients.map {|ingredient| ingredient.property.glutenFree}.all?
			#return ingredients[0].property.glutenFree
		end
end
