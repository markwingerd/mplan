class QueuedRecipesController < ApplicationController

	def create
		queued_recipe = QueuedRecipe.create(queued_recipe_params)

		redirect_to recipe_path(queued_recipe.recipe_id)
	end

	def destroy
		queued_recipe = QueuedRecipe.find(params[:id])
		queued_recipe.destroy

		redirect_to :controller => "ingredients_list", :action => "index"
	end

	private
		def queued_recipe_params
			params.permit(:recipe_id, :user_id)
		end

end