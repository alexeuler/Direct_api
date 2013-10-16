# -*- coding: utf-8 -*-
require_relative 'lib/api'
require_relative 'lib/cookie'
require_relative 'lib/parse'
require_relative 'lib/bids'
require_relative 'lib/db'

def request_and_parse
  doc=RestClient.get "https://direct.yandex.ru/registered/main.pl?cmd=showCamp&cid=7634904&ulogin=", :cookies => Cookie.FromFile(File.expand_path(File.join(File.dirname(__FILE__), "cookie.txt")))
  result=Parse.CampaignParams(doc)
  result.each do |x|
    DB.insert(x)
  end
  Bids.strategy1
end

loop do
  request_and_parse
  sleep(300+rand(20))
end
