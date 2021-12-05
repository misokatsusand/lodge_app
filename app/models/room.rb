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
class Room < ApplicationRecord
  belongs_to :user
  has_many :users,through: :books

  with_options presence: true do
    validates :area
    validates :price_per_day_and_person
    validates :user_id
    with_options uniqueness: true do
      validates :name
    end
  end
  
  #ルーム検索用クラスメソッド
  def self.search(search_area,search_keyword)
    #"%%"によるLIKE検索回避用
    if search_area.present?
      area = "%#{search_area}%"
    end
    if search_keyword.present?
      keyword = "%#{search_keyword}%"
    end
    #検索フォームに入力された値に応じActiveRecordへwhereをチェーンする
    if area.present? and keyword.present?
      where("(area LIKE ?) and ((comment LIKE ?) or (name LIKE ?))", "#{area}", "#{keyword}", "#{keyword}")
    elsif area.present? or keyword.present?
      where("(area LIKE ?) or (comment LIKE ?) or (name LIKE ?)", "#{area}", "#{keyword}", "#{keyword}")
    else
      all
    end
  end
end
