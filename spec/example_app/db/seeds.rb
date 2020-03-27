Movie.destroy_all
Genre.destroy_all
client = TmdbClient.new

GenreSync.run(client: client)
MovieSync.run(client: client)
