# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.first_or_create(username: 'admin', password: '1234567', admin: true)
11.times do |index|
  User.where(username: 'user1', password: index.to_s * 7).first_or_create(username: 'user1', password: index.to_s * 7)
end
%w{A B C D E}.each do |name|
  disk = Disk.where(name: name).first_or_create(name: name)
  attr = {disk_id: disk.id, name: "file#{rand(5)}.txt"}
  Content.where(attr).first_or_create(attr)
end