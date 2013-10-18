require 'rest_client'
require 'json'

module Api

  @@default_params={
    token:"9ee8968e579349688929c2048c5efe14",
    application_id:"d003cf921af84c3b972f866797c4c41a",
    locale:"ru"
}

  def self.CallApi(params)
    data=@@default_params.merge!(params).to_json
    RestClient.post("https://api.direct.yandex.ru/json-api/v4/", data).force_encoding("UTF-8")
  end

  def self.GetClientInfo (params)
    self.CallApi method:"GetClientInfo", param:params
  end

  def self.GetCampaignsList
    self.CallApi method:"GetCampaignsList"
  end

  def self.GetRegions
    self.CallApi method:"GetRegions"
  end

  def self.CreateNewForecast (phrases=[],geo=[],categories=[])
    self.CallApi method:"CreateNewForecast", param:{
      Phrases: phrases,
      Geo: geo,
      Categories: categories
    }
  end

  def self.GetForecast (params)
    self.CallApi method:"GetForecast", param:params
  end

  def self.UpdatePrices(params)
    puts self.CallApi method:"UpdatePrices", param:params
  end

  def self.GetPhrases(campaign_id)
    res=[]
    data=JSON.parse self.CallApi(method:"GetBanners", param:{
                                   CampaignIDS:campaign_id,
                                   GetPhrases:"WithPrices"
                                 })
    
    data['data'].each do |banner|
      banner['Phrases'].each do |phrase| 
        ctr=phrase['Shows']==0 ? 0 : phrase['Clicks'].to_f/phrase['Shows'].to_f*100
        prices=phrase['Prices'].sort!.reverse!
        res.push ({
                  phrase: phrase['Phrase'],
                  id1: phrase['BannerID'],
                  id2: phrase['PhraseID'],
                  impressions: phrase['Shows'],
                  clicks: phrase['Clicks'],
                  ctr: ctr.round(1),
                  pmin: phrase['PremiumMin'],
                  pmax: phrase['PremiumMax'],
                  gmin: phrase['Min'],
                  gmax: phrase['Max'],
                  price: phrase['Price'],
                  price_search: phrase['CurrentOnSearch'],
                  p1: prices[0],
                  p2: prices[1],
                  p3: prices[2],
                  p4: prices[3],
                  p5: prices[4],
                  p6: prices[5]
                })
      end
    end
    res
  end


end
