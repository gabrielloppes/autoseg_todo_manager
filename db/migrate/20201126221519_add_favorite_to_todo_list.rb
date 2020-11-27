class AddFavoriteToTodoList < ActiveRecord::Migration[6.0]
  def change
    add_column :todo_lists, :favorite, :boolean, default: false
  end
end
