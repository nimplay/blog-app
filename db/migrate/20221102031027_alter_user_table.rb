class AlterUserTable < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :postCounter, :integer, default: 0
  end
end
