require 'sqlite3'

module DB

  @path=File.expand_path(File.join(File.dirname(__FILE__), "../stats.db"))

  def self.select(where="",params=[])
    result=[]
    begin
      db = SQLite3::Database.open @path
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
      db = SQLite3::Database.open @path
      sql='delete from stats'+' '+where
      db.execute(sql,params) 
    rescue SQLite3::Exception => e
      puts "db exception: #{e}"
    end
    result
  end

  def self.insert(hash)
    begin
      columns="created_at,"
      values="datetime('now'),"
      hash.each_pair do |column, value|
        columns+="\'#{column}\',"
        values+="\'#{value}\',"
      end
      columns=columns[0, columns.length - 1]
      values=values[0, values.length - 1]
      db = SQLite3::Database.open @path
      db.execute("insert into stats (#{columns}) values (#{values})")
    rescue SQLite3::Exception => e
      puts "db exception: #{e}"
    end
  end

  def self.phrases(where="",params=[])
    begin
      result=[]
      db = SQLite3::Database.open @path
      db.execute("select distinct phrase from stats"+' '+where,params) do |item|
        result.push item
      end
    rescue SQLite3::Exception => e
      puts "db exception: #{e}"
    end
    result
  end
  
end



