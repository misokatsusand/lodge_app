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
require "test_helper"

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
