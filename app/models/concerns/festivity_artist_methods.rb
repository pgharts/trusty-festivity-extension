module Concerns
  module FestivityArtistMethods

    include ActiveSupport::Concern

    def has_social?
      (has_twitter? or has_facebook? or has_homepage? or has_instagram?)
    end

    def has_twitter?
      !self.artist_twitter.empty?
    end

    def has_facebook?
      !self.artist_facebook.empty?
    end

    def has_instagram?
      !self.artist_instagram.empty?
    end

    def has_homepage?
      !self.artist_homepage.empty?
    end


  end
end