class AddColorToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_color, :string
  end
end
