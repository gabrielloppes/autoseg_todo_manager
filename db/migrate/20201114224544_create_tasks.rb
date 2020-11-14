class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.text :description
      t.string :status
      t.references :todo_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
