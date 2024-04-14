class LineFood < ApplicationRecord
    belongs_to :food
    belongs_to :restaurant
    # 注文をするとするとは限らないので、Optional: trueを設定
    belongs_to :order, optional: true
  
    validates :count, numericality: { greater_than: 0 }
    # LINEFOOD からTrue なもののみを取り出す
    scope :active, -> { where(active: true) }
    #　店舗IDが特定の店舗でないものを返す
    scope :other_restaurant, -> (picked_restaurant_id) { where.not(restaurant_id: picked_restaurant_id) }
  
    def total_amount
      food.price * count
    end
end

  