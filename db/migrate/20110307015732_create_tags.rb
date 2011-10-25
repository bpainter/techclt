class CreateTags < ActiveRecord::Migration
  def self.up
    #drop_table :tags
    create_table :tags do |t|
      t.string :name
  
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tags
  end
end
