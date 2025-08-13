class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 200 }
  validates :body, presence: true

  scope :recent, -> { order(created_at: :desc) }

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attr_accessor :tag_list

  after_save :sync_tags_from_tag_list

  def tag_list
    @tag_list || tags.order(:name).pluck(:name).join(", ")
  end

  private

  def sync_tags_from_tag_list
    return if @tag_list.nil?

    names = @tag_list.to_s.split(/[,\s]+/).map { |n| n.strip.downcase }.reject(&:blank?).uniq
    current = tags.pluck(:name)

    to_add = names - current
    to_remove = current - names

    Tag.where(name: to_remove).find_each do |t|
      post_tags.where(tag_id: t.id).delete_all
    end

    to_add.each do |name|
      tag = Tag.find_or_create_by!(name: name)
      post_tags.find_or_create_by!(tag: tag)
    end
  end
end
