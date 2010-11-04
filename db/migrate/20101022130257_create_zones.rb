class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones, :options => "ENGINE=MyISAM" do |t|
      t.string :uuid, :limit => 36, :null => false
      t.integer :site_id, :limit => 11, :null => false
      t.string :name, :limit => 300
      t.integer :width, :limit => 11
      t.integer :height, :limit => 11
      t.integer :state_id, :limit => 3
      t.boolean :cycle, :default => false
      t.timestamps
    end
    add_index :zones, :site_id
    add_index :zones, :uuid
  end

  def self.down
    remove_index :zones, :column_name
    remove_index :zones, :column_name
    remove_index :zones, :column_name
    drop_table :zones
  end
end
