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
    RestClient.post("https://api.direct.yandex.ru/json-api/v4/", data)
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

end
