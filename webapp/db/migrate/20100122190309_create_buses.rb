class CreateBuses < ActiveRecord::Migration
  def self.up
    create_table :buses do |t|
      t.string :name
      t.string :xref
      t.references :district
      t.timestamps
    end
  end

  def self.down
    drop_table :buses
  end
end
