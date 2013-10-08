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

def self.FromFile(path)
  cookies=File.read(path)
  self.FromString(cookies.gsub("\n",""))
end
  
end
