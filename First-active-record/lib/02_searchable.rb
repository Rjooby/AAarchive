require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_keys = []
    params.each do |key, value|
      where_keys << "#{key} = ?"
    end
    where_line = where_keys.join(' AND ')

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
