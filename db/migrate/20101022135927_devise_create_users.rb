class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :options => "ENGINE=MyISAM" do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.string :firstname, :limit => 30
      t.string :lastname, :limit => 20
      t.string :phone, :limit => 12
      t.string :email, :limit => 50, :null => false
      t.string :company, :limit => 300
      t.boolean :remember_me
      t.boolean :is_admin, :null => false, :default => 0
      t.integer :state_id, :limit => 3
      t.timestamps
    end

    add_index :users, :email, :unique => true
    add_index :users, [:firstname, :lastname], :name => "index_users_name"
    add_index :users, :state_id
    add_index :users, :reset_password_token, :unique => true
  end

  def self.down
    remove_index :users, :name => :index_name
    drop_table :users
  end
end
