# class Article < ActiveRecord::Base
#
#    has_many :comments
#    has_many :taggings
#    has_many :tags, through: :taggings
#    def tag_list
#      self.tags.collect do |tag|
#     tag.name
#   end.join(", ")
#    end
#
#    def tag_list=(tags_string)
#      tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
#   new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
#   self.tags = new_or_found_tags
#
# end
# end
class Article < ActiveRecord::Base
 has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
