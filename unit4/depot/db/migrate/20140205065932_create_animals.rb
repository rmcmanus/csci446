class CreateAnimals < ActiveRecord::Migration
  def self.up
    create_table :animals do |t|
      t.string :name
      t.string :breed
      t.decimal :age, :precision => 2
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
  	drop_table :products
  end
end
