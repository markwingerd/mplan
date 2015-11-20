class RecipesController < ApplicationController

	def index
	 	query = params[:query]
	 	command_hash = {}

	 	if query # Prevents a NoMethodError if params doesn't have :query
		 	vegan_hash, query = parse_command("vegan", query)
		 	vegitarian_hash, query = parse_command("vegitarian", query)
		 	lactose_hash, query = parse_command("lactoseFree", query)
		 	gluten_hash, query = parse_command("glutenFree", query)
			command_hash = [vegan_hash, vegitarian_hash, lactose_hash, gluten_hash].reduce &:merge
		end

		search = Recipe.search do
			if command_hash.has_key?("vegan")
  				with(:vegan, command_hash["vegan"] == "true")
  			end
			if command_hash.has_key?("vegitarian")
  				with(:vegitarian, command_hash["vegitarian"] == "true")
  			end
			if command_hash.has_key?("lactoseFree")
  				with(:lactose_free, command_hash["lactoseFree"] == "true")
  			end
			if command_hash.has_key?("glutenFree")
  				with(:gluten_free, command_hash["glutenFree"] == "true")
  			end

			fulltext query do
				boost_fields :title => 2.0
				boost_fields :ingredient => 1.0
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
		#render plain: JSON.pretty_generate(params)
		populate_quantity_list_name_fields(params)
		@recipe = Recipe.new(recipe_params)
		@recipe.author_id = current_user.id
		@recipe.property = Property.new

		if @recipe.save
			@recipe.property.glutenFree = @recipe.ingredients.map {|ingredient| ingredient.property.glutenFree}.all?
			@recipe.property.lactoseFree = @recipe.ingredients.map {|ingredient| ingredient.property.lactoseFree}.all?
			@recipe.property.vegitarian = @recipe.ingredients.map {|ingredient| ingredient.property.vegitarian}.all?
			@recipe.property.vegan = @recipe.ingredients.map {|ingredient| ingredient.property.vegan}.all?

			if @recipe.property.save && @recipe.save	# @recipe.save is needed to trigger Sunspot to index that above changes to @recipe.property
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
			params.require(:recipe).permit(:title, :description, :instructions, quantities_attributes: [:listName, :amount, :ingredient_name])
		end

		def populate_quantity_list_name_fields(params)
			list_name = ""
			params[:recipe][:quantities_attributes].each do |key, quantity|
				if quantity[:listName]
					list_name = quantity[:listName]
				else
					params[:recipe][:quantities_attributes][key][:listName] = list_name
				end
			end
		end

		def parse_command(cmd, q)
			if q == nil; return q end 
			cmd_hash = {}
			clean_query = []
			if q.include?(cmd)
				tmp = q.split(cmd + ':')[1]
				clean_query << q.split(cmd + ':')[0]
				if tmp[0] == "\""
					cmd_hash[cmd] = tmp.split("\"")[1]
					clean_query << tmp.split("\"")[2..-1]
				else
					cmd_hash[cmd] = tmp.split(" ")[0]
					clean_query << tmp.split(" ")[1..-1].join(" ")
				end
			elsif !q.empty?
				clean_query << q
			end
			return cmd_hash, clean_query.join(" ")
		end
end
