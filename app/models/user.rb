# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  icon_name       :string
#  introduce       :text
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  has_many :rooms
  has_many :rooms,through: :books

  with_options presence: true do
    with_options uniqueness: true do
      validates :email
      validates :name
    end
  end
end
