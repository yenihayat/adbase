class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.integer :user_id, :null => false, :limit => 4
      t.string :name, :null => false, :unique => true, :limit => 40
      t.text :description, :limit => 300
      t.integer :width, :limit => 4
      t.integer :height, :limit => 4
      t.string :target_url, :null => false, :limit => 300
      t.boolean :track_clicks
      t.boolean :track_views
      t.integer :clicks_count, :default => 0
      t.integer :views_count, :default => 0
      t.boolean :expire
      t.datetime :expire_at
      t.integer :max_clicks_count, :default => 0
      t.integer :max_views_count, :default => 0
      t.boolean

      # Paperclip
      t.string :ad_file_name
      t.string :ad_content_type
      t.integer :ad_file_size
      t.datetime :ad_updated_at

      t.integer :state_id, :limit => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end