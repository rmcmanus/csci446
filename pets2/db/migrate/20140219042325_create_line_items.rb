class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :pet, index: true
      t.belongs_to :agency, index: true

      t.timestamps
    end
  end
end
