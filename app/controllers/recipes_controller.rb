class RecipesController < ApplicationController

	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
		#render plain: @recipe.quantities
	end

	def create
		@recipe = Recipe.create(recipe_params)

		#render plain: params
		#render plain: params["recipe"]["quantities_attributes"].values.first['ingredient_attributes']['name']
		#{"utf8"=>"✓", "authenticity_token"=>"aSUCCEaT1MqEAImjxMwibPY+y96u6VFN8J/Mi/8JQWYMLUK8MOjvW9atY/xy7dmdUxWfvhn8TBd3cGvAVPwL9Q==", "recipe"=>{"title"=>"test", "description"=>"test", "instructions"=>"test", "quantities_attributes"=>{"1443424760658"=>{"amount"=>"1", "ingredient_attributes"=>{"name"=>"1"}, "_destroy"=>"false"}}}, "commit"=>"Create Recipe", "controller"=>"recipes", "action"=>"create"}

		if @recipe.save
			flash[:success] = "Successfully created recipe"
			redirect_to @recipe
		else
			flash[:error] = "Failed to create recipe"
			render :action => 'new'
		end
	end

	def update
		@recipe = Recipe.find(params[:id])
		if (@recipe.update_attributes(recipe_params))
			redirect_to :action => "show", :id => @recipe
		else
			render :action => "edit"
		end
	end

	private
		def recipe_params
			params.require(:recipe).permit(:title, :description, :instructions, quantities_attributes: [:amount, :ingredient_id])
		end
end
