class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|

      t.timestamps
    end
  end
end
