module Tags::SocialFeedTags
  include TrustyCms::Taggable

  desc %{Instagram posts feed

        *Usage:*
<pre><code><r:instagram_posts tag="culturaltrust">/code></pre>}
  tag "instagram_posts" do |tag|

    posts = InstagramFeedService.new.get_feed_for_tag(tag.attr['tag'])
    request.env["action_controller.instance"].render_to_string :partial => "social/instagram_posts",
                                                               :locals => {:posts => posts}

  end

end
