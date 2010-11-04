class CreateSiteAds < ActiveRecord::Migration
  def self.up
    create_table :site_ads, :options => "ENGINE=MyISAM" do |t|
      t.integer :ad_id, :limit => 11, :null => false
      t.integer :site_id, :limit => 11, :null => false
      t.timestamps
    end
    add_index :site_ads, :ad_id
    add_index :site_ads, :site_id
  end

  def self.down
    drop_table :site_ads
  end
end
