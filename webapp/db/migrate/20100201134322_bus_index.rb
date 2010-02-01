class BusIndex < ActiveRecord::Migration
  def self.up
    add_index :buses, :xref, :unique => true
  end

  def self.down
    remove_index :buses, :column => :xref
  end
end
