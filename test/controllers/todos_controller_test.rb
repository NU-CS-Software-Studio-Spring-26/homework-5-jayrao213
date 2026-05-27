require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:one)
  end

  test "should get index" do
    get todos_url
    assert_response :success
  end

  test "should get new" do
    get new_todo_url
    assert_response :success
  end

  test "should create todo" do
    assert_difference("Todo.count") do
      post todos_url, params: { todo: { description: @todo.description } }
    end

    assert_redirected_to todo_url(Todo.last)
  end

  test "should show todo" do
    get todo_url(@todo)
    assert_response :success
  end

  test "should get edit" do
    get edit_todo_url(@todo)
    assert_response :success
  end

  test "should update todo" do
    patch todo_url(@todo), params: { todo: { description: @todo.description } }
    assert_redirected_to todo_url(@todo)
  end

  test "should destroy todo" do
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo)
    end

    assert_redirected_to todos_url
  end

  test "should reorder todos" do
    t1 = todos(:one)
    t2 = todos(:two)

    post reorder_todos_url, params: { todo_ids: [t2.id, t1.id] }, as: :json
    assert_response :success

    assert_equal 1, t2.reload.position
    assert_equal 2, t1.reload.position
  end

  test "should toggle high priority status via turbo stream" do
    assert_not @todo.high_priority

    patch toggle_priority_todo_url(@todo), headers: { "Accept" => "text/vnd.turbo-stream.html" }
    assert_response :success
    assert_equal "text/vnd.turbo-stream.html; charset=utf-8", response.content_type
    assert_match /turbo-stream action="replace" target="todo_\d+"/, response.body
    assert_match /class="priority-toggle-btn priority-active"/, response.body
    assert_match /★ High/, response.body

    assert @todo.reload.high_priority
  end

  test "should toggle high priority status via html redirect" do
    assert_not @todo.high_priority

    patch toggle_priority_todo_url(@todo)
    assert_redirected_to todos_url
    assert @todo.reload.high_priority
  end
end
