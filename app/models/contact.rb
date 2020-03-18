class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
  validates :email, uniqueness: true

  belongs_to :user
  
  def friendly_updated_at
    updated_at.strftime("%m/%d/%y")
  end

  def japan_phone_number
    "+81 #{phone_number}"
  end
end