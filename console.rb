require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1=Customer.new ({"name"=>"Ben","funds"=>200})
customer1.save()
customer2=Customer.new({"name"=>"Jordan","funds"=>350})
customer2.save()
customer3=Customer.new({"name"=>"Jackie","funds"=>175})
customer3.save()

customer1.name="Still Definitely Not Ben"
customer1.update

film1=Film.new({"title"=>"Guardians of the Galaxy","price"=>10})
film1.save()
film2=Film.new({"title"=>"Deadpool","price"=>12})
film2.save()
film3=Film.new({"title"=>"X-Men First Class","price"=>8})
film3.save()

film2.title= "The Life of Brian"
film2.update()

ticket1=Ticket.new({"customer_id"=>customer1.id,"film_id"=>film2.id})
ticket1.save()
ticket2=Ticket.new({"customer_id"=>customer2.id,"film_id"=>film3.id})
ticket2.save()
ticket3=Ticket.new({"customer_id"=>customer3.id,"film_id"=>film1.id})
ticket3.save()
ticket4=Ticket.new({"customer_id"=>customer1.id,"film_id"=>film2.id})
ticket4.save()
ticket4.delete()

tickets=Ticket.all
films=Film.all
customers=Customer.all

ticket_sum=Ticket.sum

binding.pry
nil