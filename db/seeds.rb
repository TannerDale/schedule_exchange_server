# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Company.destroy_all
User.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

comp = Company.create!(
  name: 'Bob Ross Inc',
  password: 'happylittletree',
  password_confirmation: 'happylittletree'
)

User.create!(
  first_name: 'Bob',
  last_name: 'Ross',
  email: 'bob_ross@painting.com',
  password: 'hello_world',
  password_confirmation: 'hello_world',
  role: 2,
  company_id: comp.id
)

User.create!(
  first_name: 'Luke',
  last_name: 'Skywalker',
  email: 'luke@theforce.com',
  password: 'iamajedi',
  password_confirmation: 'iamajedi',
  role: 1,
  company_id: comp.id
)

User.create!(
  first_name: 'Bobba',
  last_name: 'Fett',
  email: 'simple_man@likemyfather.com',
  password: 'makingwaythroughgalaxy',
  password_confirmation: 'makingwaythroughgalaxy',
  role: 0,
  company_id: comp.id
)
