class AddPositionToTodos < ActiveRecord::Migration[8.1]
  def change
    add_column :todos, :position, :integer, default: 0
    add_index :todos, :position

    reversible do |dir|
      dir.up do
        Todo.reset_column_information
        Todo.order(:created_at, :id).each_with_index do |todo, index|
          todo.update_column(:position, index + 1)
        end
      end
    end
  end
end
