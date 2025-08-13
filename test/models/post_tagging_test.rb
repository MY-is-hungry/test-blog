require "test_helper"

class PostTaggingTest < ActiveSupport::TestCase
  test "assigns tags via tag_list on create" do
    post = Post.new(title: "Hello", body: "World", tag_list: "ruby, rails")
    assert post.save
    assert_equal %w[rails ruby], post.tags.order(:name).pluck(:name)
  end

  test "updates tags via tag_list on update" do
    post = Post.create!(title: "Hello", body: "World", tag_list: "ruby rails")
    post.update!(tag_list: "rails web")
    assert_equal %w[rails web], post.tags.order(:name).pluck(:name)
  end
end

