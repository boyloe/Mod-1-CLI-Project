class CreateUserrecipesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :userrecipes do |t|
      t.references :user
      t.references :recipe
    end
  end
end
