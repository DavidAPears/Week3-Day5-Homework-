require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-bye' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Fred Bloggs', 'funds' => 50 })
customer1.save()
customer2 = Customer.new({ 'name' => 'Jane Doe', 'funds' => 40 })
customer2.save()
customer3 = Customer.new({ 'name' => 'Frank White', 'funds' => 25 })
customer3.save()
customer4 = Customer.new({ 'name' => 'Sam Jones', 'funds' => 10 })
customer4.save()
customer5 = Customer.new({ 'name' => 'Mark Smith', 'funds' => 17 })
customer5.save()


film1 = Film.new({ 'name' => 'Top Gun', 'price' => 5 })
film1.save()
film2 = Film.new({ 'name' => 'Apocolypse Now', 'price' => 7 })
film2.save()
film3 = Film.new({ 'name' => 'Rambo', 'price' => 4 })
film3.save()
film4 = Film.new({ 'name' => 'E.T', 'price' => 7 })
film4.save()
film5 = Film.new({ 'name' => 'Back To The Future', 'price' => 6 })
film5.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()

binding.pry
nil
