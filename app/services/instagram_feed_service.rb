class InstagramFeedService

  def initialize
    @client = Instagram.client(:access_token => ENV['INSTAGRAM_ACCESS_TOKEN'])
  end

  def get_feed_for_tag(tag)
    tagged_posts = @client.user_recent_media.select{|post| post[:tags].include?(tag.downcase)}
    tagged_posts.map do |post|
      Social::InstagramPostPresenter.from_instagram_post(post)
    end
  end

end