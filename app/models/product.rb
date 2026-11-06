class Product < ApplicationRecord
  has_many :cart_items
  has_many :order_details
  has_many :orders, through: :order_details

  # バリデーション
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true

  # Active Storage（商品画像）
  has_one_attached :photo

  # 商品画像のサムネイルを生成
  def thumbnail
    photo.variant(resize_to_limit: [150, 150]).processed
  end

  # Enum（販売状況）
  enum :status, { on_sale: 0, sold_out: 1 }

  # 検索（Ransack）
  def self.ransackable_attributes(auth_object = nil)
    %w[name price]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end