require('pg')
require_relative('../db/sql_runner.rb')

class Album

attr_accessor :title, :artist_id, :genre
attr_reader :id


def initialize(options)

@id = options['id'].to_i if options['id']
@title = options['title']
@artist_id = options['artist_id']
@genre = options['genre']

end

def save()
  sql = "INSERT INTO albums (title, artist_id, genre) VALUES ($1,$2, $3) RETURNING id"
values = [@title, @artist_id, @genre]
results = SqlRunner.run(sql, values)
@id = results[0]['id'].to_i
end

def artist()
  sql = "SELECT * FROM artists WHERE id = $1"
  values = [@artist_id]
  artist = SqlRunner.run(sql,values)[0]
  return Artist.new(artist)
end

def self.all()
  sql = "SELECT * FROM albums"
  albums = SqlRunner.run(sql)
  return albums.map{|album| Album.new(album)}
end

def self.delete_all()
  sql = "DELETE FROM albums"
  SqlRunner.run(sql)
end

def update()
    sql = "UPDATE albums SET (title, genre) = ($1, $2) WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql,values)
end



end
