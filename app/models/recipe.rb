class Recipe < ActiveRecord::Base
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
end
