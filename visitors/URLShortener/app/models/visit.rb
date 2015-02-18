class Visit < ActiveRecord::Base
  validates :url_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(
                  user_id: user.id,
                  url_id: shortened_url.id
                  )
  end



  belongs_to :shortened_url,
              class_name: "ShortenedUrl",
              foreign_key: :url_id

  belongs_to :user,
              class_name: "User",
              foreign_key: :user_id


end
