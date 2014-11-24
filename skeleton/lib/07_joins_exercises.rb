# == Schema Information
#
# Table name: actor
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movie
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director    :integer
#
# Table name: casting
#
#  movieid     :integer      not null, primary key
#  actorid     :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
  SELECT
    title
  FROM
    movie
  INNER JOIN
    casting ON movie.id = casting.movieid
  INNER JOIN
    actor ON casting.actorid = actor.id
  WHERE
    actor.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
  SELECT
    movie.title
  FROM
    movie
  INNER JOIN
    casting ON movie.id = casting.movieid
  INNER JOIN
    actor ON casting.actorid = actor.id
  WHERE
    actor.name = 'Harrison Ford' AND casting.ord <> 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
  SELECT
    movie.title, actor.name
  FROM
    movie
  INNER JOIN
    casting ON movie.id = casting.movieid
  INNER JOIN
    actor ON casting.actorid = actor.id
  WHERE
    movie.yr = 1962 AND casting.ord = 1

  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
  SELECT
    movie.yr, COUNT(movie.title)
  FROM
    movie
  INNER JOIN
    casting ON movie.id = casting.movieid
  INNER JOIN
    actor ON casting.actorid = actor.id
  WHERE
    actor.name = 'John Travolta'
  GROUP BY
    movie.yr
  HAVING
    COUNT(movie.title) > 1
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      julie_movie.title, lead_actor.name
    FROM
      movie AS julie_movie
    JOIN
      casting AS julie_casting ON julie_casting.movieid = julie_movie.id
    JOIN
      actor AS julie_actor ON julie_casting.actorid = julie_actor.id
    JOIN
      casting AS lead_casting ON julie_casting.movieid = lead_casting.movieid
    JOIN
      actor AS lead_actor ON lead_casting.actorid = lead_actor.id
    WHERE
      julie_actor.name = 'Julie Andrews' AND lead_casting.ord = 1
      --
      -- casting.ord = 1 AND movie.id IN (
      --   SELECT
      --     casting.movieid
      --   FROM
      --     casting
      --   JOIN
      --     actor ON casting.actorid = actor.id
      --   WHERE
      --     actor.name = 'Julie Andrews'
      -- )
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      actor.name
    FROM
      actor
    JOIN
      casting ON casting.actorid = actor.id
    JOIN
      movie ON casting.movieid = movie.id
    WHERE
      casting.ord = 1
    GROUP BY
      actor.name
    HAVING
      COUNT(movie.title) > 14
    ORDER BY
      actor.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast.
  execute(<<-SQL)
    SELECT
      movie.title, COUNT(actor.id)
    FROM
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      movie.yr = 1978
    GROUP BY
      movie.title
    ORDER BY
      COUNT(casting.actorid) DESC
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have worked with 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      coll_actors.name
    FROM
      actor as coll_actors
    JOIN
      casting as coll_casting ON coll_casting.actorid = coll_actors.id
    JOIN
      movie as coll_movies ON coll_casting.movieid = coll_movies.id
    JOIN
      casting as art_casting ON art_casting.movieid = coll_casting.movieid
    JOIN
      actor as art_actor ON art_actor.id = art_casting.actorid
    WHERE
      art_actor.name = 'Art Garfunkel' AND coll_actors.name <> art_actor.name 
  SQL
end
