# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
1.times do |n|
  a=FactoryGirl.build(:user,:administrator)
  a.first_name="Ana"
  a.last_name="Forcada"
  a.email="ana@example.com"
  a.save
  2.times do |o|
    a.offsprings << FactoryGirl.build(:offspring, :user => a)
  end
end

 99.times do |n|
   FactoryGirl.create(:offspring)
 end

1.times do |n|
  FactoryGirl.create(:room, :name => "Virgen del Pilar", :capacity => 30)
end
