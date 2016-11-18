require_relative("../db/sql_runner")

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(params)
    @id=params["id"].to_i if params["id"]
    @title=params["title"]
    @price=params["price"].to_i
  end

  def save
    sql="INSERT INTO films (title, price)
    VALUES
    ('#{@title}',#{@price}) RETURNING *;"
    id_finder=SqlRunner.run(sql)
    @id=id_finder[0]['id'].to_i
  end

  def self.all()
      sql = "SELECT * FROM films;"
      return self.get_many(sql)
  end

  def self.delete_all() 
      sql = "DELETE FROM films;"
      SqlRunner.run(sql)
  end

  def delete
      return unless @id
      sql="DELETE FROM films WHERE id = #{@id};"
      SqlRunner.run(sql)
  end

  def update
     sql="UPDATE films SET
     (title, price) = 
     ('#{@title}',#{@price})
     WHERE id=#{@id};"
     SqlRunner.run(sql)
  end

  private

  def self.get_many(sql)
    films = SqlRunner.run(sql)
    result = films.map { |film| Film.new( film ) }
    return result
  end

end