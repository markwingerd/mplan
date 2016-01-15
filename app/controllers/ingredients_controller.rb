class IngredientsController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
    if params['base_ingredient']
      @base_ingredient = Ingredient.find_by(name: params['base_ingredient'])
    else
      @base_ingredient = Ingredient.new
      @base_ingredient.property = Property.new
    end
  end

  # If the page was submitted with a base ingredient, reload the view with the
  # bases properties prefilled out, otherwise try to save the new ingredient.
  def create
    if params['commit'] == 'Use Base'
      redirect_to action: 'new',
                  params: { base_ingredient: params[:ingredient][:name] }
    else
      if Ingredient.new(ingredient_params).save
        redirect_to action: 'index'
      else
        render action: 'new'
      end
    end
  end

  def autocomplete
    @ingredients = Ingredient.order(:name).where('name like ?',
                                                 "%#{params[:term]}%")
    render json: @ingredients.map(&:name)
  end

  def update_multiple
    changed_ingredient_ids = []
    ingredients = Ingredient.find(params[:ingredient][:ingredient].keys)

    ingredients.each do |ing|
      add_to_params(ing)
      # ingredient_params = auto_set_vegan(ingredient_params)
      ing.update_attributes!(ingredient_params_by_id(ing.id))

      changed_ingredient_ids << ing.id if ing.property.previous_changes != {}
    end

    # Update the properties of every recipe that uses these ingredients.
    update_all_recipes(changed_ingredient_ids)

    # Return to previous page.
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to)
  end

  private

  def current_page

  end

  # Add extra values to params. property_id is needed to allow rails to update
  # the record rather than create a new one. checkedByUser is set to true so
  # the creator of the ingredient doesn't always get asked to update the
  # properties of the ingredient.
  def add_to_params(ingredient)
    params[:ingredient][:ingredient][ingredient.id.to_s] \
          [:property_attributes][:id] = ingredient.property.id
    params[:ingredient][:ingredient][ingredient.id.to_s] \
          [:checkedByUser] = true
  end

  # If vegan is true then the ingredient is obviously also vegitarian.
  def auto_set_vegan(ingredient_params)
    if ingredient_params[:property_attributes][:vegan] == '1'
      ingredient_params[:property_attributes][:vegitarian] = true
    end
    return ingredient_params
  end

  # Used for creating a single ingredient.
  def ingredient_params
    params.require(:ingredient).permit(
      :name,
      :buyInWholeUnits,
      property_attributes: [
        :id,
        :vegitarian,
        :vegan,
        :lactoseFree,
        :glutenFree])
  end

  # Used for updating multiple ingredients.
  def ingredient_params_by_id(id)
    params.require(:ingredient).require(:ingredient).require(id.to_s).permit(
      :buyInWholeUnits,
      :checkedByUser,
      property_attributes: [
        :id,
        :vegitarian,
        :vegan,
        :lactoseFree,
        :glutenFree])
  end

  def update_all_recipes(ingredient_ids)
    recipes = Recipe.find_by_ingredient_ids(ingredient_ids)
    recipes.each do |recipe|
      recipe.populate_properties
      recipe.property.save
    end
  end
end
