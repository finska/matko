# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seeds for Matko

#User.create(email: 'mp4065@gmail.com')
#ShipmentCode.create(code: '373325381117900560')
# ShipmentEvent.create(time: '25.07.2017, 16:38', status: 'Handed over to the
# recipient', place: 'OULU')
# ShipmentEvent.create(time: '20.07.2017, 10:09', status: 'Ready to be collected', place:
#                            'K-MARKET OULU HÖNTTÄMÄKI/T:MI KM TASKILA, RUOTUTIE 3, OULU')
Provider.create(name: 'Matkahuolto', address: 'https://www.matkahuolto.fi/en/seuranta/tilanne/?package_code=')
Provider.create(name: 'DB Schenker', address: 'http://ng.myschenker.fi/aeseuranta/tracking.aspx?id=')
