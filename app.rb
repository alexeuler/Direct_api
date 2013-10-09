# -*- coding: utf-8 -*-
require_relative 'lib/api'
require_relative 'lib/cookie'
require_relative 'lib/parse'

def request_and_parse
  doc=RestClient.get "https://direct.yandex.ru/registered/main.pl?cmd=showCamp&cid=7634904&ulogin=", :cookies => Cookie.FromFile('cookie.txt')
  result=Parse.CampaignParams(doc)
  File.open('stats.csv', 'a:windows-1251') { |f| f.write(result) }
end

# puts Api.CreateNewForecast ["Говорящий Хомяк", "Хомяк Повторюшка"], ["213"]
request_and_parse
