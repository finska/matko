# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'mp4065@gmail.com')
Shipment.create(code: '373325381117900560')
Event.create(time: '25.07.2017, 16:38', status: 'Handed over to the
recipient', place: 'OULU')
Event.create(time: '20.07.2017, 10:09', status: 'Ready to be collected', place: 'K-MARKET OULU HÖNTTÄMÄKI/T:MI KM TASKILA, RUOTUTIE 3, OULU')