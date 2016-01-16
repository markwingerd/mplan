class Property < ActiveRecord::Base
  before_save :autoset_vegitarian

  belongs_to :ingredient
  belongs_to :recipe

  def set_all_true
    self.glutenFree = true
    self.lactoseFree = true
    self.vegitarian = true
    self.vegan = true
  end

  private

  def autoset_vegitarian
    if self.vegan
      self.vegitarian = true
    end
  end
end
