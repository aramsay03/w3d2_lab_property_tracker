require("pg")

class Properties

  attr_reader :id
  attr_accessor :address, :value, :bedrooms, :build

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @address = options["address"]
    @value = options["value"].to_i()
    @bedrooms = options["bedrooms"].to_i()
    @build = options["build"]
  end

  def save()
    db = PG.connect({
      dbname: "properties",
      host: "localhost"
      })
    sql = "INSERT INTO properties
    (address, value, bedrooms, build)
    VALUES
    ($1, $2, $3, $4) RETURNING id"
    values = [@address, @value, @bedrooms, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values).first()["id"].to_i
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: "properties",
      host: "localhost"
      })
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    @id = db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({
      dbname: "properties",
      host: "localhost"
      })
    sql = "UPDATE properties
    SET
    (address, value, bedrooms, build) =
    ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@address, @value, @bedrooms, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def self.find(id)
    db = PG.connect({
      dbname: "properties",
      host: "localhost"
      })
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    results_array = db.exec_prepared("find", values)
    db.close()
    property_hash = results_array[0]
    found_property = Properties.new(property_hash)
    return found_property
  end

  def self.find_by_address(address)
    db = PG.connect({
      dbname: "properties",
      host: "localhost"
      })
    sql = "SELECT * FROM properties WHERE address = $1"
    values = [address]
    db.prepare("find", sql)
    results_array = db.exec_prepared("find", values)
    db.close()
    property_hash = results_array[0]
    found_property = PizzaOrder.new(property_hash)
    return found_property
  end

  def self.all()
    db = PG.connect({
      dbname: "properties",
      host: "localhost"
      })
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    return properties.map {|property| Properties.new(property)}
  end

  def self.delete_all()
    db = PG.connect({
      dbname: "properties",
      host: "localhost"
      })
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

end
