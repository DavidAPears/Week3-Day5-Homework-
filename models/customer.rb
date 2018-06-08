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
#
#   def locations()
#     sql = "SELECT locations.*
#     FROM locations
#     INNER JOIN visits
#     ON visits.location_id = locations.id
#     WHERE user_id = $1"
#     values = [@id]
#     location_data = SqlRunner.run(sql, values)
#     return Location.map_items(location_data)
#   end
#
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


#   def self.delete_all()
#    sql = "DELETE FROM users"
#    SqlRunner.run(sql)
#   end
#

#
end
