require 'pry'

class Pokemon
  attr_accessor :name, :type, :db, :hp
  attr_reader :id

  @@all = []

  def initialize(props={})
    @id = props['id']
    self.name = props['name']
    self.type = props['type']
    self.hp = props['hp']
    self.db = props['db']
    @@all << self
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?,?)", name, type)
  end

  def self.find(id, db)
    db.results_as_hash = true
    row = db.execute("SELECT * FROM pokemon WHERE id = ?", id)
    self.new(row[0])
  end

  def alter_hp(integer, db)
    self.hp = integer
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", integer, self.id)
  end

end
