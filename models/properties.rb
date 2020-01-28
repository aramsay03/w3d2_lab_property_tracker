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

end
