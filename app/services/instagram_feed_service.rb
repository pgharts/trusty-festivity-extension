class InstagramFeedService

  def initialize
    @client = Instagram.client
  end

  def get_feed_for_tag(tag)
    @client.tag_recent_media(tag).map do |post|
      Social::InstagramPostPresenter.from_instagram_post(post)
    end
  end

end