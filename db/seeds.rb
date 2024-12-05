# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


require 'csv'

file_path = Rails.root.join('db', 'seeds', 'merchants.csv')

CSV.foreach(file_path, col_sep: ';', headers: true) do |row|
  Merchant.find_or_create_by(
    uuid: row['id'],
    reference: row['reference']
  ) do |merchant|
    merchant.email = row['email']
    merchant.live_on = row['live_on']
    merchant.disbursement_frequency = row['disbursement_frequency']
    merchant.minimum_monthly_fee = row['minimum_monthly_fee']
  end
end

puts "Merchant data seeded from CSV."
