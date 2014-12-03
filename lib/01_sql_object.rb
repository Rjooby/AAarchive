require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns if @columns
    table = DBConnection.execute2("SELECT * FROM #{table_name}")[0]

    @columns = table.map!(&:to_sym)
  end

  def self.finalize!
    columns.each do |col_name|
      define_method(col_name) do
        self.attributes[col_name]
      end

      define_method("#{col_name}=") do |value|
        self.attributes[col_name] = value
      end
    end

  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL

    parse_all(results)
  end

  def self.parse_all(results)
    results.map do |hash|
      self.new(hash)
    end

  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL

    parse_all(result).first

  end

  def initialize(params = {})
    params.each do |key, value|
      if self.class.columns.include?(key.to_sym)
        send("#{key.to_sym}=", value )
      else
        raise "unknown attribute '#{key.to_sym}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |value|
      self.send(value)
    end
  end

  def insert
    col_names = self.class.columns.join(', ')
    count = self.class.columns.length
    question_marks = (['?'] * count).join(', ')

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id

  end

  def update
    set_line = self.class.columns.map { |i| "#{i} = ?" }.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{ self.class.table_name }
      SET
        #{ set_line }
      WHERE
        #{ self.class.table_name }.id = ?
    SQL

  end

  def save
    id.nil? ? insert : update
  end
end
