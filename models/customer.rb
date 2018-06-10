require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id, :name
  attr_accessor :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i

  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return Customer.map_items(customer_data)
  end

  def self.map_items(customer_data)
    result = customer_data.map { |customer| Customer.new( customer ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def films()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON tickets.films_id = films.id
    WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

  def ticket_purchased # reduce customers funds
    sql = "SELECT films.*
    FROM films
    WHERE id = $1"
    values = [@id]
    purchase = SqlRunner.run(sql, values)[0]
    @customer.funds -= purchase['price'].to_i
    @customer.update
  end

  def ticket_added #updates customer with new ticket
    sql = "SELECT films.*
    FROM films
    WHERE id =$1"
    values = [@id]
    purchase = SqlRunner.run(sql, values)[0]
    @customer.funds -= purchase['price'].to_i
    @customer.update
    ticket = Ticket.new({
    'customer_id' => self.id,
    'film_id' => film.id
    })
    ticket.save()
  end



end
