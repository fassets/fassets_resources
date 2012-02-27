class ClassificationsController < FassetsCore::ApplicationController
  before_filter :authenticate_user!
  before_filter :find_classification, :only => [:update, :destroy]

  respond_to :html, :js

  def create
    if params[:asset_id]
      classification = Classification.new(:asset_id => params[:asset_id],:catalog_id => params[:catalog_id])
    else
      classification = Classification.new(params[:classification])
    end
    classification.save
    render :nothing => true
  end
  def destroy
    @classification.destroy
    render :nothing => true
  end
  def update
    if params[:commit] == "Drop"
      @classification.destroy()
      return
    end
    @classification.label_ids = params[:labels]
    flash[:notice] = "Updated Classification"
    respond_with do |format|
      format.js
      format.html {}
    end
  end

  protected
  def find_classification
    @classification = Classification.find(params[:id])
  end
end

