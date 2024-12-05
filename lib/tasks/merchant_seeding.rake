namespace :db do
  desc "Seed Merchant data from merchants.csv file"
  task seed_merchants: :environment do
    require "csv"

    # Path to the CSV file
    file_path = Rails.root.join("db", "seeds", "merchants.csv")

    # Check if the file exists
    unless File.exist?(file_path)
      puts "CSV file not found at #{file_path}"
      exit
    end

    puts "Seeding Merchant data from #{file_path}..."

    CSV.foreach(file_path, col_sep: ";", headers: true) do |row|
      merchant = Merchant.find_or_create_by(
        uuid: row["id"],
        reference: row["reference"]
      ) do |merchant|
        merchant.email = row["email"]
        merchant.live_on = row["live_on"]
        merchant.disbursement_frequency = row["disbursement_frequency"]
        merchant.minimum_monthly_fee = row["minimum_monthly_fee"]
      end

      if merchant.persisted?
        puts "Merchant #{merchant.reference} (#{merchant.uuid}) successfully seeded."
      else
        puts "Failed to seed Merchant: #{row['reference']}. Errors: #{merchant.errors.full_messages.join(', ')}"
      end
    end

    puts "Merchant seeding completed."
  end
end
