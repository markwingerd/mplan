class Quantity < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  belongs_to :ingredient

  accepts_nested_attributes_for :ingredient,
                                reject_if: :all_blank

  def ingredient_name
    ingredient.try(:name)
  end

  def ingredient_name=(name)
    self.ingredient = Ingredient.find_by_name(name) if name.present?
  end
end
