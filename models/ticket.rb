require_relative("../db/sql_runner")
require_relative('customer')
require_relative('film')

class Ticket

  attr_reader :id, :customer_id, :film_id

  def initialize(params)
    @id=params["id"].to_i if ["id"]
    @customer_id=params["customer_id"].to_i
    @film_id=params["film_id"].to_i
  end

  def save()
    sql="INSERT INTO tickets (customer_id,film_id)
    VALUES
    (#{@customer_id},#{@film_id}) RETURNING *;"
    id_finder=SqlRunner.run(sql)
    @id=id_finder[0]['id'].to_i
  end

  def self.all()
      sql = "SELECT * FROM tickets;"
      return self.get_many(sql)
  end

  def self.delete_all() 
      sql = "DELETE FROM tickets;"
      SqlRunner.run(sql)
  end

  def delete()
      return unless @id
      sql="DELETE FROM tickets WHERE id = #{@id};"
      SqlRunner.run(sql)
  end

  def update
     sql="UPDATE customers SET
     (customer_id, film_id) = 
     (#{@customer_id},#{@film_id})
     WHERE id=#{@id};"
     SqlRunner.run(sql)
  end

  def customer()
      sql = "SELECT * FROM customers WHERE id=#{@customer_id};"
      result = SqlRunner.run(sql)
      customer = Customer.new(result[0])
      return customer
  end

  def film()
      sql = "SELECT * FROM films WHERE id=#{@film_id};"
      result = SqlRunner.run(sql)
      film = Film.new(result[0])
      return film
  end

  def sum()
    
  end

  private

  def self.get_many(sql)
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

end