class AddBgPreferenceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :bg_preference, :integer
  end
end
