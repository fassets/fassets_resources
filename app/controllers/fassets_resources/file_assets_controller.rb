require 'wikipedia'

module FassetsResources
  class FileAssetsController < AssetsController
    skip_before_filter :authenticate_user!, :only => [:thumb, :preview, :original]
    skip_before_filter :find_content, :only => [:wikipedia_images]

    def thumb
      redirect_to "/public/uploads/#{@content.id}/thumb.#{params[:format]}"
    end
    def preview
      if @content.media_type == "video"
        render :template => 'file_assets/video_player', :layout => false
      else
        redirect_to @content.file_url
      end
    end
    def original
      redirect_to "/public/uploads/#{@content.id}/original.#{params[:format]}"
    end
    def content_model
      return FileAsset
    end
    def wikipedia_images
      @content = FileAsset.new
      Wikipedia.Configure {
        domain 'en.wikipedia.org'
        #domain 'commons.wikimedia.org'
        path   'w/api.php'
      }
      page = Wikipedia.find(params[:search_key])
      image_urls = page.image_urls
      render :partial => 'wikipedia_images', :locals => {:search_key => params[:search_key], :image_urls => image_urls}
    end
  end
end

