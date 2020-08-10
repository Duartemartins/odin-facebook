# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# (53..152).each { |id| User.find(id).delete }
# (53..142).each do |id|
#   user = User.find(id)
#   user.avatar.attach(Faker::Avatar.image(size: '50x50', format: 'jpg')).save unless user.avatar.attached?
# end
2.times do
  user = User.new(
    #name: Faker::Internet.user_name,
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: Faker::Internet.password
    avatar: Faker::Avatar.image(size: '50x50', format: 'jpg')
  )
  user.save!
end
