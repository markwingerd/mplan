class IngredientsListController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = User.find(current_user.id)

    @all_ingredients = get_ingredients(@user)
    # render plain: JSON.pretty_generate(@all_ingredients)
  end

  def show
  end

  def update
    @user = User.find(current_user)

    if @user.update(user_params)
      redirect_to action: :index
    else
      render 'edit'
    end
  end

  def print
    @user = User.find(current_user.id)
    if params[:table_ingredients]
      @all_ingredients = get_ingredients(@user)
    elsif params[:all_recipes]
      @all_recipes = @user.recipes
    end

    render layout: 'print'
  end

  private

  def user_params
    params.require(:user).permit(quantities_attributes:
                                 [:id,
                                  :amount,
                                  :ingredient_name,
                                  :_destroy])
  end

  # Takes an array of quantity records and returns a hash of string:quantity
  # values.
  def qtys_to_hash(quantities)
    ret_value = {}
    quantities.each do |qty|
      if ret_value.keys.include?(qty.ingredient.name)
        ret_value[qty.ingredient.name] += qty.amount
      else
        ret_value[qty.ingredient.name] = qty.amount
      end
    end
    return ret_value
  end

  def recipe_qtys_to_arr(recipes)
    ret_value = []
    recipes.each do |recipe|
      ret_value << recipe.quantities
    end
    return ret_value
  end

  def assemble_qtys_list(recipe_qtys, stocked_qtys)
    all_qtys = []
    recipe_qtys.each do |name, qty|
      if stocked_qtys.keys.include?(name)
        all_qtys << [[name, qty], [name, stocked_qtys[name]]]
        stocked_qtys.delete(name)
      else
        all_qtys << [[name, qty], [nil, nil]]
      end
    end
    stocked_qtys.each do |name, qty|
      all_qtys << [[nil, nil], [name, qty]]
    end

    return all_qtys
  end

  def get_ingredients(user)
    stocked_qtys = qtys_to_hash(user.quantities)
    recipe_qtys = qtys_to_hash(recipe_qtys_to_arr(user.recipes).flatten)
    all_qtys = assemble_qtys_list(recipe_qtys, stocked_qtys)
    return all_qtys
  end
end
