require 'ruby-units'

class Quantity < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  belongs_to :ingredient

  accepts_nested_attributes_for :ingredient,
                                reject_if: :all_blank

  def +(other)
    new_unit = get_unit(self) + get_unit(other)
    return Quantity.new(ingredient: ingredient,
                        amount: new_unit.scalar,
                        measurement: new_unit.units)
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

  # Class method to take an array of quantities and create a hash of unique
  # string:quantity pairs using ingredient.name as the key.
  def self.to_hash(quantity_array)
    ret_value = {}
    quantity_array.each do |qty|
      if ret_value.keys.include?(qty.ingredient.name)
        ret_value[qty.ingredient.name] += qty
      else
        ret_value[qty.ingredient.name] = qty
      end
    end
    return ret_value
  end

  private

  def get_unit(qty)
    return Unit.new(qty.amount.to_s + ' ' + qty.measurement)
  end
end
