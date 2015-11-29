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

end
