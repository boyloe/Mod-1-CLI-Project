class CreateUserrecipesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :user_recipes do |t|
      t.references :user
      t.references :recipe
    end
  end
end
