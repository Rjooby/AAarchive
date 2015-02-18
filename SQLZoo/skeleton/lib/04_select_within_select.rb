# == Schema Information
#
# Table name: world
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def example_select_with_subquery
  execute(<<-SQL)
    SELECT
      name
    FROM
      world
    WHERE
      population > (
        SELECT
          population
        FROM
          world
        WHERE
          name='Romania'
        )
  SQL
end

def larger_than_russia
  # List each country name where the population is larger than 'Russia'.
  execute(<<-SQL)
    SELECT
      name
    FROM
      world
    WHERE
      population > (
        SELECT
          population
        FROM
          world
        WHERE
          name = 'Russia'
      )
  SQL
end

def richer_than_england
  # Show the countries in Europe with a per capita GDP greater than
  # 'United Kingdom'.
  execute(<<-SQL)
    SELECT
      name
    FROM
      world
    WHERE
      continent = 'Europe' AND gdp/population > (
          SELECT
            gdp/population
          FROM
            world
          WHERE
            name = 'United Kingdom'

      )

  SQL
end

def neighbors_of_b_countries
  # List the name and continent of countries in the continents containing
  # 'Belize', 'Belgium'.
  execute(<<-SQL)
    SELECT
      name, continent
    FROM
      world
    WHERE
      continent IN (
        SELECT
          continent
        FROM
          world
        WHERE
          name = 'Belize' OR name = 'Belgium'
      )
  SQL
end

def population_constraint
  # Which country has a population that is more than Canada but less than
  # Poland? Show the name and the population.
  execute(<<-SQL)
    SELECT
      name, population
    FROM
      world
    WHERE
      population > (
        SELECT
          population
        FROM
          world
        WHERE
          name = 'Canada'
      ) AND population < (
        SELECT
          population
        FROM
          world
        WHERE
          name = 'Poland'
      )

  SQL
end

# To get a well rounded view of the important features of SQL you should move
# on to the next tutorial concerning aggregates.

# To gain an absurdly detailed view of one insignificant feature of the
# language, read on.

# We can use the word ALL to allow >= or > or < or <=to act over a list.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      world
    WHERE
      gdp > ALL(
        SELECT
          gdp
        FROM
          world
        WHERE
          continent = 'Europe' AND GDP is not null
        )

  SQL
end

# We can refer to values in the outer SELECT within the inner SELECT. We can
# name the tables so that we can tell the difference between the inner and
# outer versions.

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      largest_countries.continent, largest_countries.name, largest_countries.area
    FROM
      world as largest_countries
    WHERE
      largest_countries.area > ALL(
        SELECT
          other_countries.area
        FROM
          world AS other_countries
        WHERE
          largest_countries.continent = other_countries.continent AND
          largest_countries.name <> other_countries.name
        )
  SQL
end

# BONUS QUESTIONS: these are difficult questions that utilize techniques not
# covered in prior sections:

def sparse_continents
  # Find each country that belongs to a continent where all populations are
  # less than 25,000,000. Show name, continent and population.
  execute(<<-SQL)
    SELECT
      sparse_countries.name, sparse_countries.continent, sparse_countries.population
    FROM
      world as sparse_countries
    WHERE
       sparse_countries.continent IN (
        SELECT
          other_countries.continent
        FROM
          world as other_countries
        WHERE
          sparse_countries.continent = other_countries.continent AND
          25000000 > ALL (
            SELECT
              each_country.population
            FROM
              world as each_country
            WHERE
             each_country.continent = sparse_countries.continent
          )
        )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      large_countries.name, large_countries.continent
    FROM
      world as large_countries
    WHERE
      large_countries.population > ALL(
        SELECT
          neighbors.population * 3
        FROM
          world AS neighbors
        WHERE
          neighbors.continent = large_countries.continent AND
          large_countries.name <> neighbors.name
      )

  SQL
end
