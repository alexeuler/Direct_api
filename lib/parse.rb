require 'nokogiri'
require 'open-uri'

module Parse
  def self.CampaignParams(data)
    result=[]
    doc=Nokogiri::HTML.parse(data)
    doc.css('tr.b-phrases-list-phrase').each do |x|
      ids=x.css('.b-edit-phrase-price__price')[0]['name'].split("_")
      result.push({
        created_at: Time.now,
        phrase: x.css('.b-phrases-list-phrase__key-words')[0].children.to_s,
        id1: ids[1],
        id2: ids[2],
        impressions: x.css('.b-phrases-list-phrase__Shows')[0].children.to_s.gsub(" ","").gsub("\r","").gsub("\n",""),
        clicks: x.css('.b-phrases-list-phrase__clicks')[0].children.to_s.gsub(" ","").gsub("\r","").gsub("\n",""),
        ctr: x.css('.b-phrases-list-phrase__Ctr')[0].children.to_s.gsub(" ","").gsub("\r","").gsub("\n",""),
        pmax: x.css('.b-phrases-list-phrase__pmax')[0].children.to_s,
        pmin: x.css('.b-phrases-list-phrase__pmin')[0].children.to_s,
        gmax: x.css('.b-phrases-list-phrase__max')[0].children.to_s,
        gmin: x.css('.b-phrases-list-phrase__min')[0].children.to_s,
        price: x.css('.b-edit-phrase-price__price')[0]['value'],
        price_search: x.css('.b-phrases-list-phrase__search-price')[0].children.to_s
      })
    end
    result
  end
end
