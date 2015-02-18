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

def example_select
  execute(<<-SQL)
    SELECT
      population
    FROM
      world
    WHERE
      name = 'France'
  SQL
end

def select_population_of_germany
  execute(<<-SQL)
    SELECT
      population
    FROM
      world
    WHERE
      name = 'Germany'
  SQL
end

def per_capita_gdp
  # Show the name and per capita gdp (gdp/population) for each country where
  # the area is over 5,000,000 km^2
  execute(<<-SQL)
    SELECT
      name, gdp/population
    FROM
      world
    WHERE
      area > 5000000
  SQL
end

def small_and_wealthy
  # Show the name and continent of countries where the area is less than 2,000
  # and the gdp is more than 5,000,000,000.
  execute(<<-SQL)
    SELECT
      name, continent
    FROM
      world
    WHERE
      area < 2000 AND gdp > 5000000000
  SQL
end

def scandinavia
  # Show the name and the population for 'Denmark', 'Finland', 'Norway', and
  # 'Sweden'
  execute(<<-SQL)
    SELECT
      name, population
    FROM
      world
    WHERE
      name IN ('Denmark', 'Finland', 'Norway', 'Sweden')
  SQL
end

def starts_with_g
  # Show each country that begins with the letter G
  execute(<<-SQL)
  SELECT
    name
  FROM
    world
  WHERE
    name LIKE 'G%'

  SQL
end

def just_the_right_size
  # Show the country and the area for countries with an area between 200,000
  # and 250,000. BETWEEN allows range checking - note that it is inclusive.
  execute(<<-SQL)
  SELECT
    name, (area / 1000)
  FROM
    world
  WHERE
    area BETWEEN 200000 AND 249999
  SQL
end