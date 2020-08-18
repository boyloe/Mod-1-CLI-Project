class Recipe < ActiveRecord::Base
   has_many :userrecipes
   has_many :users, through: :userrecipes
end