class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.text :description
      t.text :habits
      t.string :image_url

      t.timestamps
    end
  end
end
