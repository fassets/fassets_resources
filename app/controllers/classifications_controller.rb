class ClassificationsController < FassetsCore::ApplicationController
  before_filter :authenticate_user!
  before_filter :find_classification, :only => [:update, :destroy]

  respond_to :html, :js

  def create
    classification = Classification.new(params[:classification])
    classification.save
    redirect_to url_for(classification.asset.content) + "/edit"
  end
  def destroy
    @classification.destroy
    redirect_to url_for(@classification.asset.content) + "/edit"
  end
  def update
    if params[:commit] == "Drop"
      destroy()
      return
    end
    @classification.label_ids = params[:labels]
    flash[:notice] = "Updated Classification"
    respond_with do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  protected
  def find_classification
    @classification = Classification.find(params[:id])
  end
end

