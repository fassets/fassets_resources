class FileAssetsController < AssetsController
  skip_before_filter :authenticate_user!, :only => [:thumb, :preview, :original]

  def new
    @content = FileAsset.new
    render :template => 'file_assets/new'
  end
  def create
    @content = FileAsset.new(params[:file_asset])
    @content.asset = Asset.create(:user => current_user, :name => @content.file.filename.to_s)

    respond_to do |format|
      if @content.save
        classification = Classification.new(:catalog_id => params["classification"]["catalog_id"],:asset_id => @content.asset.id)
        classification.save
        format.json { render :json => [ @content.to_jq_upload ].to_json }
      else
        format.json { render :json => [ @content.to_jq_upload.merge({ :error => "custom_failure" }) ].to_json }
      end
    end
  end
  def update
    @content = FileAsset.find(params[:id])

    respond_to do |format|
      if @content.asset.update_attributes(params[:asset])
        format.html { redirect_to @content, :notice => 'Picture was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @content.errors, :status => :unprocessable_entity }
      end
    end
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
end

