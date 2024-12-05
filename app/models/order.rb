class Order < ApplicationRecord
  belongs_to :merchant

  before_create :generate_custom_id

  private

  def generate_custom_id
    self.id = SecureRandom.hex(6) # Generates a 12-character alphanumeric string
  end
end
