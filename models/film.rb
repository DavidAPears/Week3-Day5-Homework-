require_relative("../db/sql_runner.rb")

class Film

  attr_reader :id, :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end

  def self.map_items(film_data)
     result = film_data.map { |film| Film.new( film ) }
     return result
  end

  def self.delete_all()
   sql = "DELETE FROM films"
   SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.user_id = customers.id
    WHERE films_id = $1"
    values = [@id]
    user_data = SqlRunner.run(sql, values)
    return Customer.map_items(customer_data)
  end

end
