class AssetsController < FassetsCore::ApplicationController
  include AssetsHelper
  before_filter :authenticate_user!, :except => [:show]
  before_filter :find_content, :except => [:new, :new_remote_file, :create, :preview, :markup_preview,:copy, :get_wiki_imgs, :search_wiki_imgs, :add_asset_box]

  def new
    @content = self.content_model.new
    render :template => 'assets/new'
  end
  def create
    @content = self.content_model.new(content_params)
    @content.asset = Asset.create(:user => current_user, :name => params["asset"]["name"])
    if @content.save
      classification = Classification.new(:catalog_id => params["classification"]["catalog_id"],:asset_id => @content.asset.id)
      classification.save
      flash[:notice] = "Created new asset!"
      #redirect_to asset_content_path(@content) + "/edit"
      render :template => asset_content_path(@content) + "/edit", :locals => {:in_fancybox => false}
    else
      render :template => 'assets/new'
    end
  end
  def show
    render :template => 'assets/show'
  end
  def edit
    render :template => 'assets/edit', :locals => {:in_fancybox => false}
  end
  def update
    if @content.update_attributes(content_params) and @content.asset.update_attributes(params["asset"])
      flash[:notice] = "Succesfully updated asset!"
      redirect_to asset_content_path(@content) + "/edit"
    else
      flash[:error] = "Could not update asset!"
      render :template => 'assets/edit'
    end
  end
  def destroy
    flash[:notice] = "Asset has been deleted!"
    @content.destroy
    redirect_to root_url
  end
  def preview
    content_id = Asset.find(params[:id]).content_id
    @content = self.content_model.find(content_id)
    render :partial => content_model.to_s.underscore.pluralize + "/" + @content.media_type.to_s.underscore + "_preview"
  end
  def markup_preview
    render :inline => PandocRuby.convert(params["markup"], :from => :markdown, :to => :html)
  end
  def content_model
    return Asset.find(params[:id]).content_type.constantize
  end
  def add_asset_box
    if params[:type] == "url"
      @content = Url.new
    else
      @content = FileAsset.new
    end
    render :template => "assets/add_asset_box", :layout => false, :locals => {:selected_type => params[:type] ? params[:type] : "local"}
  end
  protected
  def content_params
    field_name = self.content_model.to_s.underscore.gsub("/","_")
    logger.debug field_name
    params[field_name]
  end
  def find_content
    if params[:asset_id]
      content_id = Asset.find(params[:id]).content_id
    else
      content_id = params[:id]
    end
    @content = self.content_model.find(content_id)
  rescue ActiveRecord::RecordNotFound => e
    flash[:error] = "#{self.content_model.to_s} with id #{params[:id]} not found"
    redirect_to root_url
  end
end

