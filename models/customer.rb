require_relative("../db/sql_runner")

class Customer

  attr_reader :id :name
  attr_accessor :funds

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['fund']

  end

  def save()
    sql = "INSERT INTO customers
    (
      name, funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @price]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
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
#   def self.all()
#     sql = "SELECT * FROM users"
#     user_data = SqlRunner.run(sql)
#     return User.map_items(user_data)
#   end
#
#   def self.delete_all()
#    sql = "DELETE FROM users"
#    SqlRunner.run(sql)
#   end
#
#   def self.map_items(user_data)
#     result = user_data.map { |user| User.new( user ) }
#     return result
#   end
#
 end
