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
    user_data = SqlRunner.run(sql)
    return Customer.map_items(user_data)
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

#   def reviews()
#     sql = "SELECT locations.*, visits.*
#     FROM locations
#     INNER JOIN visits
#     ON visits.location_id = locations.id
#     WHERE user_id = $1"
#     values = [@id]
#     results = SqlRunner.run(sql, values)
#     return results.map { |result| "#{result['name']}: #{result['review']}" }
#   end
#


#
#

#
end
