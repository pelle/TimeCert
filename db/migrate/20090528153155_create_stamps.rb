class CreateStamps < ActiveRecord::Migration
  def self.up
    create_table :stamps, :id => false, :force => false do |t|
      t.column "digest","char(40) PRIMARY KEY"
      t.timestamp "created_at", :null => false
    end
  end

  def self.down
    drop_table :stamps
  end
end
