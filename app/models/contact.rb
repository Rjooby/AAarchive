class Contact < ActiveRecord::Base
  validates :email, presence: true, uniqueness:  {scope: :user_id}
  validates :user_id, :name, presence: true

  belongs_to :user
  
  has_many :contact_shares, dependent: :destroy

  has_many :shared_users, through: :contact_shares, source: :user

end
