require('pry')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')





artist1 = Artist.new({'name' => "Abba"})
artist1.save()


album1 = Album.new({
  'title' => 'Arrival', 'artist_id' => artist1.id()
  })






binding.pry
nil
