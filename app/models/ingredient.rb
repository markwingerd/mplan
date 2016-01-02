class Ingredient < ActiveRecord::Base
  has_many :quantities
  has_many :recipes, through: :quantities

  belongs_to :creator,
             class_name: 'User'

  has_one :property

  accepts_nested_attributes_for :property,
                                allow_destroy: true
end
