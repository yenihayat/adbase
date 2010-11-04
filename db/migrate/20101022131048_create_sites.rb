class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites, :options => "ENGINE=MyISAM" do |t|
      t.string :name, :limit => 300
      t.string :url, :limit => 300
      t.integer :state_id, :limit => 3
      t.timestamps
    end
    add_index :sites, :state_id
  end

  def self.down
    drop_table :sites
  end
end
