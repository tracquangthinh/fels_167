class AddLinkToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :link, :string, default: "#"
  end
end
