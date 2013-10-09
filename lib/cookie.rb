module Cookie

  def self.FromString(data)
    cookies=data.split("; ")
    result={}
    cookies.each do |c|
       /\=/.match(c)
      result.merge!({$`=>$'})
    end
    result
  end

def self.FromFile(filename)
  cookies=File.read(filename)
  self.FromString(cookies.gsub("\n",""))
end
  
end
