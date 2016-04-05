Social::TwitterPostPresenter = ImmutableStruct.new(
    :user_full_name,
    :user_id,
    :user_profile_picture_url,
    :user_username,
    :id,
    :text,
    :filter,
    :id,
    :low_res_image_url,
    :low_res_image_height,
    :low_res_image_width,
    :standard_res_image_url,
    :standard_res_image_height,
    :standard_res_image_width,
    :thumbnail_image_url,
    :thumbnail_res_image_height,
    :thumbnail_res_image_width,
    :url,
    :created_time
) do

  def self.from_twitter_post(post)
    self.new(user_full_name: post.user.name,
             user_id: post.user.id,
             user_username: post.user.screen_name,
             id: post.id,
             created_time: post.created_at,
             text: post.text,
             url: post.url)
  end
end