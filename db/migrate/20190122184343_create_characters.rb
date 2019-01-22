class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :health
      t.integer :attack
      t.integer :defense
      t.integer :user_id
      t.integer :guild_id
    end
  end
end
