class Merchant < ApplicationRecord
  has_many :orders

  validates :reference, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :live_on, presence: true
  validates :disbursement_frequency, presence: true, inclusion: { in: %w[WEEKLY DAILY] }
  validates :minimum_monthly_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
