module Tags::SocialFeedTags
  include TrustyCms::Taggable

  desc %{Instagram posts feed

        *Usage:*
<pre><code><r:instagram_posts tag="culturaltrust">/code></pre>}
  tag "instagram_posts" do |tag|
    posts = Rails.cache.fetch("instagram_posts/#{tag.attr['tag']}", expires_in: 5.minutes) do
      InstagramFeedService.new.get_feed_for_tag(tag.attr['tag'])
    end
    request.env["action_controller.instance"].render_to_string :partial => "social/instagram_posts",
                                                               :locals => {:posts => posts}

  end

  desc %{Twitter posts feed

        *Usage:*
<pre><code><r:twitter_posts tag="culturaltrust">/code></pre>}
  tag "twitter_posts" do |tag|
    posts = Rails.cache.fetch("twitter_posts/#{tag.attr['tag']}", expires_in: 5.minutes) do
      TwitterFeedService.new.get_feed_for_tag(tag.attr['tag'])
    end
    request.env["action_controller.instance"].render_to_string :partial => "social/twitter_posts",
                                                               :locals => {:posts => posts}

  end

end
