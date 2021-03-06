class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :queued_recipes
  has_many :recipes, :through => :queued_recipes
  has_many :quantities
  has_many :ingredients,
           :through => :quantities

  accepts_nested_attributes_for :quantities,
           :reject_if => :all_blank,
           :allow_destroy => true
  accepts_nested_attributes_for :ingredients
end
