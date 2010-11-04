class CreateUserSites < ActiveRecord::Migration
  def self.up
    create_table :user_sites, :options => "ENGINE=MyISAM" do |t|
      t.integer :user_id, :limit => 11, :null => false
      t.integer :site_id, :limit => 11, :null => false
      t.timestamps
    end
    add_index :user_sites, :user_id
    add_index :user_sites, :site_id
  end

  def self.down
    remove_index :user_sites, :column_name
    remove_index :user_id, :column_name
    drop_table :user_sites
  end
end
