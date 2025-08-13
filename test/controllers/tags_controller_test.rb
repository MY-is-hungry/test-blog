require "test_helper"

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "shows posts for a tag" do
    p1 = Post.create!(title: "A", body: "B", tag_list: "ruby")
    p2 = Post.create!(title: "C", body: "D", tag_list: "rails")

    get tag_path("ruby")
    assert_response :success
    assert_match p1.title, @response.body
    assert_no_match p2.title, @response.body
  end
end
