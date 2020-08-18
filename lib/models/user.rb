class User < ActiveRecord::Base
    has_many :userrecipes
    has_many :recipes, through: :userrecipes
end