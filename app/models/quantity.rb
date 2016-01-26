require 'ruby-units'

class Quantity < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  belongs_to :ingredient

  accepts_nested_attributes_for :ingredient,
                                reject_if: :all_blank

  def +(qty)
    x = Unit.new(self.amount.to_s + " " + self.measurement.downcase)
    y = Unit.new(qty.amount.to_s + " " + qty.measurement.downcase)
    new_unit = x + y
    Quantity.new(ingredient: self.ingredient, amount: new_unit.scalar, measurement: new_unit.units)
  end

  def measurement=(val)
    self[:measurement] = val.downcase
  end

  def ingredient_name
    ingredient.try(:name)
  end

  def ingredient_name=(name)
    self.ingredient = Ingredient.find_by_name(name) if name.present?
    self.ingredient ||= Ingredient.new(name: name)
    self.ingredient.property ||= Property.new
  end
end