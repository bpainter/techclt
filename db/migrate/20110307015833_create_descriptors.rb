class CreateDescriptors < ActiveRecord::Migration
  def self.up
    create_table :descriptors do |t|
      t.integer :tag_id
      t.integer :user_id
  
      t.timestamps
    end
  end
  
  def self.down
    drop_table :descriptors
  end
end
