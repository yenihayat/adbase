class CreateZoneAds < ActiveRecord::Migration
  def self.up
    create_table :zone_ads do |t|
      t.integer :zone_id, :null => false, :limit => 11
      t.integer :ad_id, :null => false, :limit => 11
      t.timestamps
    end
  end

  def self.down
    drop_table :zone_ads
  end
end
