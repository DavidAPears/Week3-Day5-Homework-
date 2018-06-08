require_relative( '../models/customer.rb' )
require_relative( '../models/film.rb' )
require_relative( '../models/ticket.rb' )

require( 'pry' )

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


film1 = Film.new({ 'title' => 'Top Gun', 'price' => 5 })
film1.save()
film2 = Film.new({ 'title' => 'Apocolypse Now', 'price' => 7 })
film2.save()
film3 = Film.new({ 'title' => 'Rambo', 'price' => 4 })
film3.save()
film4 = Film.new({ 'title' => 'E.T', 'price' => 7 })
film4.save()
film5 = Film.new({ 'title' => 'Back To The Future', 'price' => 6 })
film5.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id })
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id })
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id })
ticket3.save()

binding.pry
nil
