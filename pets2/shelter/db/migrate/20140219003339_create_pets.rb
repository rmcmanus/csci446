class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age, :default => "0"
      t.text :description
      t.string :image_url

      t.timestamps
    end
  end
end
