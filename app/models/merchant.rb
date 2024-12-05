class Merchant < ApplicationRecord
  has_many :orders

  validates :uuid, presence: true, uniqueness: true
  validates :reference, presence: true, uniqueness: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :live_on, presence: true
  validates :disbursement_frequency, presence: true, inclusion: { in: %w[WEEKLY DAILY] }
  validates :minimum_monthly_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :generate_uuid, on: :create

  private

  def generate_uuid
    self.uuid ||= SecureRandom.uuid
  end
end
