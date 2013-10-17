# -*- coding: utf-8 -*-
require_relative 'lib/api'
require_relative 'lib/cookie'
require_relative 'lib/parse'
require_relative 'lib/bids'
require_relative 'lib/db'

def request_and_parse
  Api.GetPhrases(['7634904']).each do |x|
    DB.insert(x)
  end
  Bids.strategy1
end

loop do
  request_and_parse
  sleep(300+rand(20))
end

