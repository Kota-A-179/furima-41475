class Purchase < ApplicationRecord
  has_one :address, dependent: :destroy
  belongs_to :item
  belongs_to :user
end
