# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

NUM_USERS = 51;
NUM_USERS_TO_FOLLOW = 1;

locations = ['Chicago, IL', 'Dallas, TX',
  'Los Angeles, CA', 'New York City, NY',
  'Philadelphia, PA', 'Phoenix, AZ',
  'San Diego, CA', 'San Francisco, CA']

photos = Dir.entries(Rails.root + 'seed_pictures/').select { |m| m =~ /jpg/i }

NUM_USERS.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

User.all.each do |user|
  # follow users
  User.all.sample(NUM_USERS_TO_FOLLOW).each do |user2|
    user.follow(user2)
  end

  # make Microposts
  photos.shuffle.each do |photo|
    post = user.microposts.create!(
      location: locations.sample,
      content: Faker::Lorem.characters(4),
      picture: Pathname.new(Rails.root + "seed_pictures/#{photo}").open
    )
  end
end
