# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

stations_input = CSV.open('./db/data/station_fixture.csv', headers: true, header_converters: :symbol)
stations_input.each do |station|
  Station.create!(
    id:                 station[:id],
    name:               station[:name],
    dock_count:         station[:dock_count],
    city:               station[:city],
    installation_date:  Date.strptime(station[:installation_date], "%m/%d/%Y")
  )
end

ActiveRecord::Base.connection.reset_pk_sequence!("stations")

trips_input = CSV.open('./db/data/trip_fixture.csv', headers: true, header_converters: :symbol)
trips_input.each do |trip|
  Trip.create!(
    duration:           trip[:duration],
    start_station_id:   trip[:start_station_id],
    end_station_id:     trip[:end_station_id],
    start_date:         Time.strptime(trip[:start_date], "%m/%d/%Y %H:%M"),
    end_date:           Time.strptime(trip[:end_date], "%m/%d/%Y %H:%M"),
    bike_id:            trip[:bike_id],
    subscription_type:  trip[:subscription_type],
    zip_code:           trip[:zip_code]
  )
end

User.create(first_name: 'Billy', last_name: 'Williams', address:'123 admin street', username:'admin@gmail.com', password: 'admin', role: 1)

User.create(first_name: 'Logan', last_name: 'X', address: '123 College Way', username: 'logan@gmail.com', password: '123')

Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
Item.create(price: 9.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')
Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x5', title: 'Bike Limes Over It')
Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x6', title: 'Bike Limes Never Again')
Item.create(price: 16.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x7', title: 'Bike Limes You Got It')
Item.create(price: 19.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x8', title: 'Bike Limes In Your Face')
Item.create(price: 825.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x9', title: 'Bike Limes Yup')
Item.create(price: 8500.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x10', title: 'Bike Limes Nope')
Item.create(price: 823.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x11', title: 'Bike Limes Dead')
Item.create(price: 82.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x12', title: 'Bike Limes Alive')
Item.create(price: 1.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x13', title: 'Bike Limes In Between')
Item.create(price: 99.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x14', title: 'Bike Limes Yeah')
Item.create(price: 10.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x15', title: 'Bike Limes No')


