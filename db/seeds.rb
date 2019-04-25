# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# Clear the City table before create 4 new city
City.destroy_all
4.times do 
  City.create(city_name: Faker::Address.city)
end

# Get the id of the edge of the City table
min_city_id = City.first.id
max_city_id = City.last.id

# Create 100 dogs with the city chosen randomly in the city table
Dog.destroy_all
100.times do
  Dog.create(dog_name: Faker::Creature::Dog.name, city: City.find(rand(min_city_id..max_city_id)))
end

# Create 13 dogsitters with the city chosen randomly in the city table
Dogsitter.destroy_all
13.times do
  Dogsitter.create(
    dogsitter_name: Faker::TvShows::DrWho.unique.the_doctor,
    city: City.find(rand(min_city_id..max_city_id))
    )
end

# Get the id of the edge of the Dog table
min_dog_id = Dog.first.id
max_dog_id = Dog.last.id

# Chose randomly a dog, then a dogsitter from the same city to create a stroll.
Stroll.destroy_all
200.times do
  dog = Dog.find(rand(min_dog_id..max_dog_id))
  dogsitters_in_town = Dogsitter.where(city: dog.city.id)
  dogsitter = dogsitters_in_town[rand(0...dogsitters_in_town.length)]
  Stroll.create(dog: dog, dogsitter: dogsitter)
end
