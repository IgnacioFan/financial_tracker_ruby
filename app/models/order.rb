class Order < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  attribute :status, default: "pending"

  validates :status, inclusion: %w(pending paid)
end
