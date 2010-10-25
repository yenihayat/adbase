class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.integer :category_id, :limit => 3
      t.string :title, :limit => 300
      t.timestamps
    end
  end

  def self.down
    drop_table :states
  end
end
