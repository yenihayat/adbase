class CreateZoneAds < ActiveRecord::Migration
  def self.up
    create_table :zone_ads, :options => "ENGINE=MyISAM" do |t|
      t.integer :zone_id, :null => false, :limit => 11
      t.integer :ad_id, :null => false, :limit => 11
      t.timestamps
    end
    add_index :zone_ads, :zone_id
  end

  def self.down
    remove_index :zone_id, :column_name
    drop_table :zone_ads
  end
end
