class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.create(recipe_params)

		if @recipe.save
			flash[:success] = 'Successfully created recipe'
			redirect_to @recipe
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
end
