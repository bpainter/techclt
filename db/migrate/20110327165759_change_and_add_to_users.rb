class ChangeAndAddToUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :invitation_limit, :integer, :default => 8
  end

  def self.down
  end
end
