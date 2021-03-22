# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = Admin.new(:email => 'admin@gmail.com', :password => '123456')
admin.save!

10.times do |n|
  email = "test-#{n+1}@test.com"
  password = "123456"
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  postal_code = Faker::Address.postcode
  telephone_number = Faker::PhoneNumber.phone_number
  address = Faker::Address.full_address
  Customer.create!(
   email: email,
   password: password,
   password_confirmation:  password,
   last_name: last_name,
   first_name: first_name,
   postal_code: postal_code, 
   telephone_number: telephone_number,
   address: address,
   is_deleted: false
    )
end

# 10.times do |n|
#   Item.create!(
#     genre_id "1",
#     name: "テストネーム#{n + 1}",
#     introduction: "テキスト",
#     price: "1200",
#     image: File.open('./app/assets/images/img/test.jpg'),
#     sale_status: "true"
#     )
#   end