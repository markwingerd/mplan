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

  # Assembles data for a users ingredients table.  Returns and array of
  # string:quantity:quantity arrays. The first value is an ingredient name,
  # the second is a quantity needed for a recipe, the third is a quantity the
  # user claims to already have.  [[name, gl, on]]
  def assemble_qtys_list(recipe_qtys, stocked_qtys)
    all_qtys = []
    recipe_qtys.each do |name, qty|
      all_qtys << [name, qty, stocked_qtys[name]]
      stocked_qtys.delete(name)
    end
    stocked_qtys.each do |name, qty|
      all_qtys << [name, nil, qty]
    end
    return all_qtys
  end

  def get_ingredients(user)
    stocked_qtys = Quantity.to_hash(user.quantities)
    recipe_qtys = Quantity.to_hash(user.all_recipe_quantities)
    all_qtys = assemble_qtys_list(recipe_qtys, stocked_qtys)
    return all_qtys
  end
end
