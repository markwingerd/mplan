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

  belongs_to :author, :class_name => 'User'
  has_one :property

  accepts_nested_attributes_for :quantities,
           :reject_if => :all_blank,
           :allow_destroy => true
  accepts_nested_attributes_for :ingredients

  searchable do

    text :title

    text :ingredients do
      ingredients.map { |ingredient| ingredient.name }
    end

    boolean :vegan, :stored => true do
      property.vegan
    end
    boolean :vegitarian, :stored => true  do
      property.vegitarian
    end
    boolean :lactose_free, :stored => true  do
      property.lactoseFree
    end
    boolean :gluten_free, :stored => true  do
      property.glutenFree
    end

  end
end