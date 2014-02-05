class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :animal_id
      t.integer :adoption_id

      t.timestamps
    end
  end
end
