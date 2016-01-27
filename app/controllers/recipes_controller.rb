class RecipesController < ApplicationController
  def index
    query = params[:query]

    search = Recipe.search do
      fulltext query do
        boost_fields title: 2.0
        boost_fields ingredient: 1.0
      end
    end
    @recipes = search.results
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe.assets.build
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def create
    populate_quantity_list_name_fields(params)
    @recipe = Recipe.new(recipe_params)
    @recipe.author = current_user

    if @recipe.save
      @recipe.populate_properties
      # @recipe.save is needed to trigger Sunspot to index that above changes
      # to @recipe.property
      if @recipe.property.save && @recipe.save
        redirect_to @recipe
      else
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(recipe_params)
      redirect_to action: 'show', id: @recipe
    else
      render action: 'edit'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title,
                                   :description,
                                   :instructions,
                                   assets_attributes: [:id,
                                                       :image,
                                                       :_destroy
                                                      ],
                                   quantities_attributes: [:id,
                                                           :listName,
                                                           :amount,
                                                           :measurement,
                                                           :ingredient_name,
                                                           :_destroy
                                                          ]
                                  )
  end

  def populate_quantity_list_name_fields(params)
    list_name = ''
    params[:recipe][:quantities_attributes].each do |key, quantity|
      if quantity[:listName]
        list_name = quantity[:listName]
      else
        params[:recipe][:quantities_attributes][key][:listName] = list_name
      end
    end
  end
end
