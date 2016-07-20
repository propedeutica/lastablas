# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
1.times do
  a = FactoryGirl.build(:user, :administrator)
  a.first_name = "Ana"
  a.last_name = "Forcada"
  a.email = "ana@example.com"
  a.save
  2.times do
    a.offsprings << FactoryGirl.build(:offspring, user: a, last_name: "Forcada")
  end
end

99.times do
  FactoryGirl.create(:offspring)
end

#
# Shifts for Nuestra Senora del Pilar
#
r = FactoryGirl.create(:room, name: "Nuestra Señora del Pilar", capacity: 22)
FactoryGirl.create(:shift, start_time: "18:15", end_time: "19:00", day_of_week: 2, prebooked: 0, room: r)
FactoryGirl.create(:shift, start_time: "18:15", end_time: "19:00", day_of_week: 5, prebooked: 0, room: r)
#
# Shifts for Nuestra Senora de Monserrat
#
r = FactoryGirl.create(:room, name: "Nuestra Señora de Monserrat", capacity: 22)
# Monday
FactoryGirl.create(:shift, start_time: "17:15", end_time: "18:00", day_of_week: 1, prebooked: 0, room: r)
FactoryGirl.create(:shift, start_time: "18:15", end_time: "19:00", day_of_week: 1, prebooked: 0, room: r)
# Wednesday
FactoryGirl.create(:shift, start_time: "17:15", end_time: "18:00", day_of_week: 3, prebooked: 0, room: r)
FactoryGirl.create(:shift, start_time: "18:15", end_time: "19:00", day_of_week: 3, prebooked: 0, room: r)
# Thursday
FactoryGirl.create(:shift, start_time: "18:15", end_time: "19:00", day_of_week: 4, prebooked: 0, room: r)

# Friday
FactoryGirl.create(:shift, start_time: "17:15", end_time: "18:00", day_of_week: 5, prebooked: 0, room: r)
#
# Shifts for Nuestra Senora de Covadonga
#
r = FactoryGirl.create(:room, name: "Nuestra Señora de Covadonga", capacity: 22)
FactoryGirl.create(:shift, start_time: "17:15", end_time: "18:00", day_of_week: 2, prebooked: 0, room: r)
r = FactoryGirl.create(:room, name: "Nuestra Señora de Covadonga", capacity: 22)
FactoryGirl.create(:shift, start_time: "17:15", end_time: "18:00", day_of_week: 5, prebooked: 0, room: r)
#
# Shifts for Nuestra Senora de Guadalupe
#
r = FactoryGirl.create(:room, name: "Nuestra Señora de Guadalupe", capacity: 22)
FactoryGirl.create(:shift, start_time: "17:15", end_time: "18:00", day_of_week: 3, prebooked: 0, room: r)
