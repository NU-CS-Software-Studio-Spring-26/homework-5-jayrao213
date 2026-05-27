require "test_helper"

class TodoTest < ActiveSupport::TestCase
  test "should set default position on creation" do
    max_position = Todo.maximum(:position) || 0
    todo = Todo.create!(description: "Test position callback")
    assert_equal max_position + 1, todo.position
  end

  test "should order todos by position ascending" do
    Todo.destroy_all
    t1 = Todo.create!(description: "First", position: 5)
    t2 = Todo.create!(description: "Second", position: 2)
    t3 = Todo.create!(description: "Third", position: 8)

    assert_equal [t2, t1, t3], Todo.ordered.to_a
  end
end
