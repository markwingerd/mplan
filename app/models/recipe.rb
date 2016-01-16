class Recipe < ActiveRecord::Base
  after_initialize :initialize_property

  has_many :queued_recipes
  has_many :users,
           through: :queued_recipes
  has_many :quantities
  has_many :ingredients,
           through: :quantities
  has_many :assets

  belongs_to :author,
             class_name: 'User'
  has_one :property

  accepts_nested_attributes_for :quantities,
                                reject_if: :all_blank,
                                allow_destroy: true
  accepts_nested_attributes_for :ingredients
  accepts_nested_attributes_for :assets,
                                allow_destroy: true

  searchable do
    text :title

    text :ingredients do
      ingredients.map(&:name)
    end

    boolean :vegan, stored: true do
      property.vegan
    end
    boolean :vegitarian, stored: true do
      property.vegitarian
    end
    boolean :lactose_free, stored: true do
      property.lactoseFree
    end
    boolean :gluten_free, stored: true do
      property.glutenFree
    end
  end

  def initialize_property
    self.property = Property.new if new_record?
  end

  def populate_properties
    self.property ||= Property.new

    self.property.set_all_true

    self.ingredients.each do |ing|
      self.property.glutenFree = false unless ing.property.glutenFree
      self.property.lactoseFree = false unless ing.property.lactoseFree
      self.property.vegitarian = false unless ing.property.vegitarian
      self.property.vegan = false unless ing.property.vegan
    end
  end

  def self.find_by_ingredient_ids(ingredient_ids)
    recipe_ids = Quantity.where(ingredient_id: ingredient_ids).map(&:recipe_id)
    return Recipe.where(id: recipe_ids)
  end
end
