class AddDefaultToBgPreference < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :bg_preference, from: nil, to: 1
  end
end
