class CreateStamps < ActiveRecord::Migration
  def self.up
    create_table :stamps, :primary_key => "digest", :force => true do |t|
      t.timestamp "created_at", :null => false
    end
  end

  def self.down
    drop_table :stamps
  end
end
