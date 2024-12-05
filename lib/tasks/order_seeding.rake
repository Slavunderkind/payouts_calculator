namespace :db do
  desc "Seed Orders data from CSV file"
  task seed_orders: :environment do
    require 'smarter_csv'

    # Path to the CSV file
    file_path = Rails.root.join('db', 'seeds', 'orders.csv')

    unless File.exist?(file_path)
      puts "CSV file not found at #{file_path}"
    end

    puts "Seeding Orders data from #{file_path}..."

    # Read and parse the CSV file
    # CSV.foreach(file_path, headers: true, col_sep: ';') do |row|
    #   # Find the Merchant by reference
    #   merchant = Merchant.find_by(reference: row['merchant_reference'])

    #   unless merchant
    #     puts "Merchant with reference #{row['merchant_reference']} not found. Skipping row."
    #     next
    #   end

    #   # Create or find the order
    #   order = Order.find_or_initialize_by(id: row['id'])
    #   order.merchant = merchant
    #   order.amount = row['amount']
    #   order.created_at = row['created_at']

    #   if order.save
    #     puts "Order #{order.id} for Merchant #{merchant.reference} seeded successfully."
    #   else
    #     puts "Failed to seed Order #{row['id']}: #{order.errors.full_messages.join(', ')}"
    #   end
    # end

    SmarterCSV.process(file_path, chunk_size: 1000) do |chunk|
      # Preload merchants to avoid querying for each row
      merchant_references = chunk.map { |row| row[:merchant_reference] }.uniq
      merchants = Merchant.where(reference: merchant_references).pluck(:reference, :id).to_h

      # Transform the chunk
      transformed_chunk = chunk.map do |row|
        {
          id: row[:id],
          merchant_id: merchants[row[:merchant_reference]], # Map reference to merchant_id
          amount: row[:amount],
          created_at: row[:created_at],
          updated_at: Time.current
        }
      end

      Order.insert_all(transformed_chunk)
    end

    puts "Orders seeding completed."
  end
end
