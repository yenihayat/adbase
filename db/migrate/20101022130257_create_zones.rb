class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.integer :uuid, :limit => 300
      t.integer :user_id, :limit => 4
      t.integer :site_id, :limit => 4
      t.string :name, :limit => 300
      t.integer :width, :limit => 4
      t.integer :height, :limit => 4
      t.integer :status_id, :limit => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :zones
  end
end
