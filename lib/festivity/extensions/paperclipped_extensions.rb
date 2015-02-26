module Festivity
  module Extensions
    module PaperclippedExtensions

      def async_create
        @asset = Asset.new(params[:asset])
        if @asset.save
          if params[:page]
            @page = Page.find(params[:page])
            existing_asset = @page.assets.find_by_title(@asset.title)
            @page.assets.delete(existing_asset) if not existing_asset.nil?
            @asset.pages << @page
          end
          render :text => @asset.thumbnail(:thumbnail)
        else
          head :internal_server_error
        end
      end

    end
  end
end