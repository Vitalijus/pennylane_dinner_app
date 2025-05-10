# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'

file = File.open(Rails.root.join('recipes-en.json')).read
json_data = JSON.parse file

json_data.each do |data|
  create_recipe = Recipe.create!({
    title: data["title"],
    cook_time: data["cook_time"],
    prep_time: data["prep_time"],
    ingredients: data["ingredients"],
    ratings: data["ratings"],
    cuisine: data["cuisine"],
    category: data["category"],
    author: data["author"],
    image: data["image"]
  })
end
