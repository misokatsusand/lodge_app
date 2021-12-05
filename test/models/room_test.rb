# == Schema Information
#
# Table name: rooms
#
#  id                       :integer          not null, primary key
#  area                     :string
#  comment                  :text
#  image_name               :string
#  name                     :string
#  price_per_day_and_person :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  user_id                  :integer
#
require "test_helper"

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
