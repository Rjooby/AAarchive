class TagTopic < ActiveRecord::Base
  validates :tag,
    presence: true,
    inclusion: { in: %w(news sports music) },
    uniqueness: true

  has_many :taggings,
            class_name: "Tagging",
            foreign_key: :tag_index

  has_many :urls,
            through: :taggings,
            source: :shortened_url
end
