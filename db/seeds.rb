# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

3.times do |n|
    restaurant = Restaurant.new(
      name: "testレストラン_#{n}",
      fee: 100,
      time_required: 10,
    )
  
    12.times do |m|
      restaurant.foods.build(
        name: "フード名_#{m}",
        price: 500,
        description: "フード_#{m}の説明文です。"
      )
    end
  
    restaurant.save!
end

  