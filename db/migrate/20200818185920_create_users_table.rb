class CreateUsersTable < ActiveRecord::Migration[6.0]
  def change
    create_table :Users do |t|
      t.string :username     
    end
  end
end
