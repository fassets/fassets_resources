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
    @content = FileAsset.new(params[:file_asset])
    @content.asset = Asset.create(:user => current_user, :name => @content.file.filename.to_s)
    respond_to do |format|
      if @content.save
        @classification = Classification.new(:catalog_id => params["classification"]["catalog_id"],:asset_id => @content.asset.id)
        @classification.save
        create_content_labeling(@content.asset.id, params["classification"]["catalog_id"])
        format.json { render :json => [ @content.to_jq_upload ].to_json }
        if params[:file_asset][:remote_file_url]
          format.html { render :action => "edit", :locals => {:in_fancybox => false}, :notice => 'Remote File was successfully added.'}
          format.json { head :ok }
        end
      else
        format.json { render :json => [ @content.to_jq_upload.merge({ :error => "custom_failure" }) ].to_json }
      end
    end
  end
  def update
    content_id = Asset.find(params[:id]).content_id
    @content = FileAsset.find(content_id)
    logger.debug("Content"+@content.to_s)
    respond_to do |format|
      if @content.asset.update_attributes(params[:asset]) and @content.update_attributes(params[:file_asset])
        format.html { render :nothing => true}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @content.errors, :status => :unprocessable_entity }
      end
    end
  end
  def edit_box
    @content = FileAsset.find(params[:id])
    if params["_"]
      new = true
    else
      new = false
    end
    render :template => 'assets/edit', :layout => false, :locals => {:new => new}
  end
  def thumb
    redirect_to "/public/uploads/#{@content.id}/thumb.#{params[:format]}"
  end
  def preview
    redirect_to "/public/uploads/#{@content.id}/small.#{params[:format]}"
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
    Wikipedia.Configure {
     domain 'en.wikipedia.org'
     #domain 'commons.wikimedia.org'
     path   'w/api.php'
    }
    page = Wikipedia.find(params[:search_key])
    image_urls = page.image_urls
    render :partial => 'file_assets/search_wiki_imgs', :locals => {:search_key => params[:search_key], :image_urls => image_urls}
  end
  def get_wiki_imgs
    @content = FileAsset.new
    render :template => "file_assets/new_wiki_img"
  end
  def create_content_labeling(asset_id,catalog_id)
    asset = Asset.find(asset_id)
    content_facet = Facet.where(:catalog_id => catalog_id, :caption => "Content Type").first
    content_facet.labels.each do |label|
      if asset.content_type == "FileAsset"
        if label.caption.downcase == asset.content.media_type
          labeling = Labeling.new(:classification_id => @classification.id, :label_id => label.id)
          labeling.save
        end
      elsif asset.content_type == "Url"
        if label.caption == "Url"
          labeling = Labeling.new(:classification_id => @classification.id, :label_id => label.id)
          labeling.save
        end
      elsif asset.content_type == "Code"
        if label.caption == "Code"
          labeling = Labeling.new(:classification_id => @classification.id, :label_id => label.id)
          labeling.save
        end
      elsif asset.content_type == "FassetsPresentations::Presentation"
        if label.caption == "Presentation"
          labeling = Labeling.new(:classification_id => @classification.id, :label_id => label.id)
          labeling.save
        end
      end
    end
  end
end

