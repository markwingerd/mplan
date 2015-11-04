class Recipe < ActiveRecord::Base
  # attr_accessible :title,
  #                 :description,
  #                 :instructions,
  #                 :quantities_attributes

  has_many :queued_recipes
  has_many :users, :through => :queued_recipes
  has_many :quantities
  has_many :ingredients,
           :through => :quantities

  has_one :property

  accepts_nested_attributes_for :quantities,
           :reject_if => :all_blank,
           :allow_destroy => true
  accepts_nested_attributes_for :ingredients

  searchable do
    text :title
  end
end