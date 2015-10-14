class QueuedRecipesController < ApplicationController

	def create
		queued_recipe = QueuedRecipe.create(queued_recipe_params)

		redirect_to recipe_path(queued_recipe.recipe_id)
	end

	private
		def queued_recipe_params
			params.permit(:recipe_id, :user_id)
		end

end