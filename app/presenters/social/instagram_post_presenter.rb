Social::InstagramPostPresenter = ImmutableStruct.new(
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

    def self.from_instagram_post(post)
      self.new(user_profile_picture_url: post.user.profile_picture,
               user_full_name: post.user.full_name,
               user_id: post.user.id,
               user_username: post.user.username,
               id: post.id,
               created_time: Time.at(post.created_time.to_i),
               text: post.caption.text,
               filter: post.filter,
               low_res_image_url: post.images.low_resolution.url,
               low_res_image_height: post.images.low_resolution.height,
               low_res_image_width: post.images.low_resolution.width,
               standard_res_image_url: post.images.standard_resolution.url,
               standard_res_image_height: post.images.standard_resolution.height,
               standard_res_image_width: post.images.standard_resolution.width,
               thumbnail_image_url: post.images.thumbnail.url,
               thumbnail_image_height: post.images.thumbnail.height,
               thumbnail_image_width: post.images.thumbnail.width,
               url: post.link)

    end
  end