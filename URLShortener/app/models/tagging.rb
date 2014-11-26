class Tagging < ActiveRecord::Base
  validates :url_index, presence: true
  validates :tag_index, presence: true


  def self.create_tag(shortenedurl, tagtopic)
    Tagging.create!(
                    url_index: shortenedurl.id,
                    tag_index: tagtopic.id
                    )
  end



  belongs_to :shortened_url,
              foreign_key: :url_index

  belongs_to :tag_topic,
              foreign_key: :tag_index



end
