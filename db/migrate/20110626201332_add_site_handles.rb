class AddSiteHandles < ActiveRecord::Migration
  def self.up
    create_table "site_handles" do |t|
      t.column "node_id", :integer
      t.column "twitter", :string
      t.column "github", :string
    end
  end

  def self.down
    drop_table "site_handles"
  end
end
