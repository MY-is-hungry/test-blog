require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "normalizes and validates uniqueness" do
    Tag.create!(name: "Ruby")
    dup = Tag.new(name: " ruby ")
    assert_not dup.valid?
    assert_includes dup.errors[:name], "has already been taken"
  end
end

