class Ingredient < ActiveRecord::Base
  has_many :quantities
  has_many :recipes, through: :quantities

  has_one :property

  accepts_nested_attributes_for :property,
                                allow_destroy: true
end
