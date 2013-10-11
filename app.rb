# -*- coding: utf-8 -*-
require_relative 'lib/api'
require_relative 'lib/cookie'
require_relative 'lib/parse'
require_relative 'lib/bids'

def request_and_parse
  doc=RestClient.get "https://direct.yandex.ru/registered/main.pl?cmd=showCamp&cid=7634904&ulogin=", :cookies => Cookie.FromFile(File.expand_path(File.join(File.dirname(__FILE__), "cookie.txt")))
  result=Parse.CampaignParams(doc)
  Bids.UpdateAll result
  File.open(File.join(File.dirname(__FILE__), "stats.csv"), 'a:windows-1251') { |f| f.write(result) }

end

loop do
  request_and_parse
  sleep(300+rand(20))
end
