require 'wikipedia'

class FileAssetsController < AssetsController
  skip_before_filter :authenticate_user!, :only => [:thumb, :preview, :original]

  def new
    @content = FileAsset.new
    render :template => 'file_assets/new'
  end
  def create
    if params[:remote_file_url]
      file_asset_hash = {:file_asset => {:remote_file_url => params[:remote_file_url], :source => params[:source]}}
      params.merge!(file_asset_hash)
    end
    logger.debug(params)
    @content = FileAsset.new(params[:file_asset])
    @content.asset = Asset.create(:user => current_user, :name => @content.file.filename.to_s)
    respond_to do |format|
      if @content.save
        classification = Classification.new(:catalog_id => params["classification"]["catalog_id"],:asset_id => @content.asset.id)
        classification.save
        format.json { render :json => [ @content.to_jq_upload ].to_json }
        if params[:file_asset][:remote_file_url]
          format.html { redirect_to @content, :notice => 'FileAsset was successfully updated.' }
          format.json { head :ok }
        end
      else
        format.json { render :json => [ @content.to_jq_upload.merge({ :error => "custom_failure" }) ].to_json }
      end
    end
  end
  def update
    @content = FileAsset.find(params[:id])
    respond_to do |format|
      if @content.asset.update_attributes(params[:asset]) and @content.update_attributes(params[:file_asset])
        format.html { redirect_to @content, :notice => 'FileAsset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @content.errors, :status => :unprocessable_entity }
      end
    end
  end
  def edit_box
    @content = FileAsset.find(params[:id])
    render :template => 'assets/edit', :layout => false
  end
  def thumb
    redirect_to "/public/uploads/#{@content.id}/thumb.#{params[:format]}"
  end
  def preview
    redirect_to "/public/uploads/#{@content.id}/small.#{params[:format]}"
    #render :partial => @content.class.to_s.underscore.pluralize + "/" + @content.media_type.to_s.underscore + "_preview"
  end
  def original
    redirect_to "/public/uploads/#{@content.id}/original.#{params[:format]}"
  end
  def content_model
    return FileAsset
  end
  def new_remote_file
    @content = FileAsset.new
    render :template => 'file_assets/new_remote_file'
  end
  def search_wiki_imgs
    @content = FileAsset.new
    page = Wikipedia.find(params[:file_asset][:search_key])
    images = page.images
    image_urls = page.image_urls
    render :template => 'file_assets/search_wiki_imgs', :locals => {:search_key => params[:file_asset][:search_key], :image_urls => image_urls}
  end
  def get_wiki_imgs
    @content = FileAsset.new
    render :template => "file_assets/new_wiki_img"
  end
end

