class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :expense
  belongs_to :prefecture
  belongs_to :shipping_date

  belongs_to :user
  has_one_attached :image

  validates :image, presence: { message: "を入力してください" }
  validates :name, presence: { message: "を入力してください" }, length: { maximum: 40, message: "は40字以内で入力してください" }
  validates :content, presence: { message: "を入力してください" }, length: { maximum: 1000, message: "は1000字以内で入力してください" }
  validates :category_id, presence: { message: "を入力してください" }, numericality: { other_than: 1, message: "を入力してください" }
  validates :condition_id, presence: { message: "を入力してください" }, numericality: { other_than: 1, message: "を入力してください" }
  validates :expense_id, presence: { message: "を入力してください" }, numericality: { other_than: 1, message: "を入力してください" }
  validates :prefecture_id, presence: { message: "を入力してください" }, numericality: { other_than: 1, message: "を入力してください" }
  validates :shipping_date_id, presence: { message: "を入力してください" }, numericality: { other_than: 1, message: "を入力してください" }
  validates :price, presence: { message: "を入力してください" }, numericality: { in: 300..9999999, message: "は300円以上、999万999円以下で設定してください"}
  

end
