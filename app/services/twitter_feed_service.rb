class TwitterFeedService

  def initialize
    # @client = Twitter::REST::Client.new(config)
    @client = $twitter_client
  end

  #note: needed to remove trafficjamnet because of the bogus TRAF tweets they do

  def get_feed_for_tag(tag)
    @client.search("##{tag} -rt -from:trafficjamnet", result_type: "recent", lang: "en").take(50).each do |tweet|
      Social::TwitterPostPresenter.from_twitter_post(tweet)
    end
  end

end