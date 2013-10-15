require 'sqlite3'

module DB
  def self.select(where="",params=[])
    result=[]
    begin
      db = SQLite3::Database.open "stats.db"
      db.results_as_hash=true
      sql='select * from stats'+' '+where
      db.execute(sql,params) do |row|
        result.push row
      end
    rescue SQLite3::Exception => e
      puts "db exception: #{e}"
    end
    result
  end

  def self.delete(where="",params=[])
    begin
      db = SQLite3::Database.open "stats.db"
      sql='delete from stats'+' '+where
      db.execute(sql,params) 
    rescue SQLite3::Exception => e
      puts "db exception: #{e}"
    end
    result
  end


  def self.insert(hash)
    begin
      columns=""
      values=""
      hash.each_pair do |column, value|
        columns+="\'#{column}\',"
        values+="\'#{value}\',"
      end
      columns=columns[0, columns.length - 1]
      values=values[0, values.length - 1]
      db = SQLite3::Database.open "stats.db"
      db.execute("insert into stats (#{columns}) values (#{values})")
    rescue SQLite3::Exception => e
      puts "db exception: #{e}"
    end
    
  end


end
