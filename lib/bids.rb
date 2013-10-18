require_relative 'api'
require_relative 'db'

module Bids

  def self.strategy1
    params={
      min: 1,
      max: 20,
      upside: 0.25
    }
    api_data=[]
    phrases=DB.phrases "where created_at>datetime('now','-1 days')"
    phrases.each do |phrase|
      data=DB.select "where phrase is \'#{phrase[0]}\' and created_at>datetime('now', '-30 minutes')"
      prices=data.map {|row| row['pmin']}
      min_price=prices.min        # minimum price in last 30 minutes
      last_price=data.last['pmin']
      id=data.last['id2']
      api_data.push({ PhraseID: id, Price: params[:max]/25.5}) if min_price<params[:max]*(1+params[:upside]) and last_price!=params[:max]
      api_data.push({ PhraseID: id, Price: params[:min]/25.5}) if min_price>params[:max]*(1+params[:upside]) and last_price!=params[:min]
    end
    Api.UpdatePrices api_data
  end

end
