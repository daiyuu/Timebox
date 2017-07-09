# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.find_or_create_by(id: 1) do |user|
  user.username = '河原大雄'
  user.email = 'k.daiyuu.bb@gmail.com'
  user.password = 'bigU1213'
end
