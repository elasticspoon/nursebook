# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all
Post.destroy_all

20.times do
  user = User.create!(email: Faker::Internet.email, password: Faker::Internet.password)
  user.create_profile!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  5.times do
    user.posts.create!(content: Faker::Lorem.paragraph)
  end
end

5.times do
  User.all.each do |user|
    Post.all.sample.comments.create!(content: Faker::Lorem.paragraph, creator: user)
  end
end

10.times do
  User.all.each do |user|
    Comment.all.sample.comments.create!(content: Faker::Lorem.paragraph, creator: user)
  end
end

User.all.each do |user|
  Post.all.sample(5).each { |post| user.liked_posts << post }
  Comment.all.sample(10).each { |comment| user.liked_comments << comment }
end

User.create!(email: 'test@example.com', password: 'password')
