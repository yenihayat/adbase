class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :name, :limit => 300
      t.string :url, :limit => 300
      t.integer :state_id, :limit => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
