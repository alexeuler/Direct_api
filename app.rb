# -*- coding: utf-8 -*-
require_relative 'lib/api'
require_relative 'lib/cookie'
# puts Api.CreateNewForecast ["Говорящий Хомяк", "Хомяк Повторюшка"], ["213"]
#puts Cookie.FromFile 'cookie.txt'
#puts Cookie.FromString("yandexuid=674842901381264533; ys=udn.a2FyYXNldi5hbGV4ZXkyMDEz; yp=1696624543.udn.a2FyYXNldi5hbGV4ZXkyMDEz; yandex_login=karasev.alexey2013; sessionid2=2:1381264543.14.5.226308623.8:1381264543118:774366631:83.1.1.1.0.99788.1844.cc86224f2821419adad0372457249f8a; my=YzYBAAA=; L=Z2t7B15lAnd6fV9XWEZsRgNDQ2VVd1ZJHiAEdiZCcGMjPSgIBBcrJFoTPBcaVCBfVEcLHUB7KSsQLCcIOR1bBg==.1381264543.10008.219110.70e94e555b2d425fb74348e619631cea; Session_id=2:1381264543.14.0.226308623.8:1381264543118:774366631:83.0.1.1.0.99788.280.02c63a028c1226758d477dd6d189ee21")
puts RestClient.get "https://direct.yandex.ru/registered/main.pl?cmd=showCamp&cid=7634904&ulogin=", :cookies => Cookie.FromFile('cookie.txt')
