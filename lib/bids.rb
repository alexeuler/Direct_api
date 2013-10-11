require_relative 'api'

module Bids


def self.Update(data_csv)
@cap=15.0
@small=1.0

  @s=data_csv.gsub(',','.').split(';')
  @data={
    year: @s[0].to_i,
    month: @s[1].to_i,
    day: @s[2].to_i,
    hour: @s[3].to_i,
    minute: @s[4].to_i,
    second: @s[5].to_i,
    phrase: @s[6],
    ad_id: @s[7].to_i,
    phrase_id: @s[8].to_i,
    impressions: @s[9].to_i,
    clicks: @s[10].to_i,
    ctr: @s[11].to_f,
    pmax: @s[12].to_f,
    pmin: @s[13].to_f,
    max: @s[14].to_f,
    min: @s[15].to_f,
    price: @s[16].to_f
  }

  return { PhraseID: @data[:phrase_id], Price: @small/25.5} if @data[:pmin]>@cap and @data[:price]>(@cap+@small)/2
  return { PhraseID: @data[:phrase_id], Price: [@data[:pmin]+0.3,@cap].max/25.5} if @data[:pmin]<=@cap*1.1 and @data[:price]<(@cap+@small)/2
  nil
end

def self.UpdateAll(data_csv)
  @data=data_csv.split("\n")
  @arr=[]
  @data.each do |chunk|
    @result=self.Update(chunk)
    @arr.push @result unless @result.nil?
  end
  Api.UpdatePrices @arr
end

end
