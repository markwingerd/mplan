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
    puts @ingredients.map(&:name)
    render json: @ingredients.map(&:name)

  end

  def update_multiple
    ingredients = Ingredient.find(params[:ingredient][:ingredient].keys)
    ingredients.each do |ingredient|
      add_property_id_to_params(ingredient)
      ingredient_params = ingredient_params_by_id(ingredient.id)
      ingredient_params = auto_set_vegan(ingredient_params)
      ingredient.update_attributes!(ingredient_params)
    end

    redirect_to action: 'index'
  end

  private

  # Add property_id to params to allow rails to update the record rather
  # than create a new one.
  def add_property_id_to_params(ingredient)
    params[:ingredient][:ingredient][ingredient.id.to_s] \
          [:property_attributes][:id] = ingredient.property.id
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
      property_attributes: [
        :id,
        :vegitarian,
        :vegan,
        :lactoseFree,
        :glutenFree])
  end
end
