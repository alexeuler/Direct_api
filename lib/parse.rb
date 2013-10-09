require 'nokogiri'
require 'open-uri'

module Parse
  def self.CampaignParams(data)
    result=""
    doc=Nokogiri::HTML.parse(data)
    time=Time.now
    doc.css('tr.b-phrases-list-phrase').each do |x|
      result+=time.year.to_s+";"+time.month.to_s+";"+time.day.to_s+";"+time.hour.to_s+";"+time.min.to_s+";"+time.sec.to_s+";"
      result+=x.css('.b-phrases-list-phrase__key-words')[0].children.to_s+";"
      tmp=x.css('.b-edit-phrase-price__price')[0]['name'].split("_")
      result+=tmp[1]+";"
      result+=tmp[2]+";"
      tmp=x.css('.b-phrases-list-phrase__Shows')[0].children.to_s
      tmp.gsub!(" ","")
      tmp.gsub!("\n","")
      tmp.gsub!("\r","")
      result+=tmp+";"
      tmp=x.css('.b-phrases-list-phrase__clicks')[0].children.to_s
      tmp.gsub!(" ","")
      tmp.gsub!("\n","")
      tmp.gsub!("\r","")
      result+=tmp+";"
      tmp=x.css('.b-phrases-list-phrase__Ctr')[0].children.to_s
      tmp.gsub!(" ","")
      tmp.gsub!("\n","")
      tmp.gsub!("\r","")
      result+=tmp+";"
      result+=x.css('.b-phrases-list-phrase__pmax')[0].children.to_s+";"
      result+=x.css('.b-phrases-list-phrase__pmin')[0].children.to_s+";"
      result+=x.css('.b-phrases-list-phrase__max')[0].children.to_s+";"
      result+=x.css('.b-phrases-list-phrase__min')[0].children.to_s+";"
      result+=x.css('.b-edit-phrase-price__price')[0]['value']+"\n"
    end
    result.gsub!('.',',')
    result
  end
end
