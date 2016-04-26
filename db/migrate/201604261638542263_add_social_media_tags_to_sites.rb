class AddSocialMediaTagsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :social_media_tag, :string
  end
end