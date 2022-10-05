# == Schema Information
#
# Table name: books
#
#  id               :integer          not null, primary key
#  days             :integer
#  end              :datetime
#  number_of_people :integer
#  start            :datetime
#  total_price      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  room_id          :integer
#  user_id          :integer
#
class Book < ApplicationRecord
  belongs_to :user
  belongs_to :room

  with_options presence: true do
    validates :user_id
    validates :room_id
    validates :start
    validates :end
    validates :number_of_people
    validates :total_price
  end
end
