class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :title, :status, :frequency, :price

  enum status: { active: 0, inactive: 1 }
end