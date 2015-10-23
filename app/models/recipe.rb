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

  accepts_nested_attributes_for :quantities,
           :reject_if => :all_blank,
           :allow_destroy => true
  accepts_nested_attributes_for :ingredients

  def self.search(query)
    where("title LIKE ?", "%#{query}%")
  end
end