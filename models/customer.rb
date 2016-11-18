require_relative("../db/sql_runner")

class Customer 

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(params)
    @id=params["id"].to_i if params["id"]
    @name=params["name"]
    @funds=params["funds"].to_i
  end

  def save
    sql="INSERT INTO customers (name, funds)
    VALUES
    ('#{@name}',#{@funds}) RETURNING *;"
    id_finder=SqlRunner.run(sql)
    @id=id_finder[0]['id'].to_i
  end

  def self.all()
      sql = "SELECT * FROM customers;"
      return self.get_many(sql)
  end

  def self.delete_all() 
      sql = "DELETE FROM customers;"
      SqlRunner.run(sql)
  end

  def update
     sql="UPDATE customers SET
     (name, funds) = 
     ('#{@name}',#{@funds})
     WHERE id=#{@id};"
     SqlRunner.run(sql)
  end

  private

  def self.get_many(sql)
    customers = SqlRunner.run(sql)
    result = customers.map { |customer| Customer.new( customer ) }
    return result
  end

end